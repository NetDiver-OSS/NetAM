
module Fugit

  class Cron

    SPECIALS = {
      '@reboot' => :reboot,
      '@yearly' => '0 0 1 1 *',
      '@annually' => '0 0 1 1 *',
      '@monthly' => '0 0 1 * *',
      '@weekly' => '0 0 * * 0',
      '@daily' => '0 0 * * *',
      '@midnight' => '0 0 * * *',
      '@noon' => '0 12 * * *',
      '@hourly' => '0 * * * *' }
    MAXDAYS = [
      nil, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

    attr_reader(
      :original, :zone)
    attr_reader(
      :seconds, :minutes, :hours, :monthdays, :months, :weekdays, :timezone)

    class << self

      def new(original)

        parse(original)
      end

      def parse(s)

        return s if s.is_a?(self)

        s = SPECIALS[s] || s

        return nil unless s.is_a?(String)

#p s; Raabro.pp(Parser.parse(s, debug: 3), colors: true)
        h = Parser.parse(s)

        return nil unless h

        self.allocate.send(:init, s, h)
      end

      def do_parse(s)

        parse(s) ||
        fail(ArgumentError.new("invalid cron string #{s.inspect}"))
      end
    end

    def to_cron_s

      @cron_s ||= [
        @seconds == [ 0 ] ? nil : (@seconds || [ '*' ]).join(','),
        (@minutes || [ '*' ]).join(','),
        (@hours || [ '*' ]).join(','),
        (@monthdays || [ '*' ]).join(','),
        (@months || [ '*' ]).join(','),
        (@weekdays || [ [ '*' ] ]).map { |d| d.compact.join('#') }.join(','),
        @timezone ? @timezone.name : nil
          ].compact.join(' ')
    end

    class TimeCursor

      def initialize(cron, t)
        @cron = cron
        @t = t.is_a?(TimeCursor) ? t.time : t
        @t.seconds = @t.seconds.to_i
      end

      def time; @t; end
      def to_i; @t.to_i; end

      %w[ year month day wday hour min sec wday_in_month rweek rday ]
        .collect(&:to_sym).each { |k| define_method(k) { @t.send(k) } }

      def inc(i)
        @t = @t + i
        self
      end
      def dec(i); inc(-i); end

      def inc_month
        y = @t.year
        m = @t.month + 1
        if m == 13; m = 1; y += 1; end
        @t = ::EtOrbi.make(y, m, @t.zone)
        self
      end

      def inc_day
        inc((24 - @t.hour) * 3600 - @t.min * 60 - @t.sec)
      end
      def inc_hour
        inc((60 - @t.min) * 60 - @t.sec)
      end
      def inc_min
        inc(60 - @t.sec)
      end

      def inc_sec
        if sec = @cron.seconds.find { |s| s > @t.sec }
          inc(sec - @t.sec)
        else
          inc(60 - @t.sec + @cron.seconds.first)
        end
      end

      def dec_month

        #dec(@t.day * 24 * 3600 + @t.hour * 3600 + @t.min * 60 + @t.sec + 1)
          #
          # gh-18, so that '0 9 29 feb *' doesn't get skipped (over and over)
          #
        dec(@t.day * 24 * 3600 + 1)
      end

      def dec_day
        dec(@t.hour * 3600 + @t.min * 60 + @t.sec + 1)
      end
      def dec_hour
        dec(@t.min * 60 + @t.sec + 1)
      end
      def dec_min
        dec(@t.sec + 1)
      end

      def dec_sec
        target =
          @cron.seconds.reverse.find { |s| s < @t.sec } ||
          @cron.seconds.last
        inc(target - @t.sec - (@t.sec > target ? 0 : 60))
      end
    end

    def month_match?(nt); ( ! @months) || @months.include?(nt.month); end
    def hour_match?(nt); ( ! @hours) || @hours.include?(nt.hour); end
    def min_match?(nt); ( ! @minutes) || @minutes.include?(nt.min); end
    def sec_match?(nt); ( ! @seconds) || @seconds.include?(nt.sec); end

    def weekday_hash_match?(nt, hsh)

      phsh, nhsh = nt.wday_in_month

      if hsh > 0
        hsh == phsh # positive wday, from the beginning of the month
      else
        hsh == nhsh # negative wday, from the end of the month, -1 == last
      end
    end

    def weekday_modulo_match?(nt, mod)

      nt.rweek % mod[0] == mod[1]
    end

    def weekday_match?(nt)

      return true if @weekdays.nil?

      wd, hom = @weekdays.find { |d, _| d == nt.wday }

      return false unless wd
      return true if hom.nil?

      if hom.is_a?(Array)
        weekday_modulo_match?(nt, hom)
      else
        weekday_hash_match?(nt, hom)
      end
    end

    def monthday_match?(nt)

      return true if @monthdays.nil?

      last = (TimeCursor.new(self, nt).inc_month.time - 24 * 3600).day + 1

      @monthdays
        .collect { |d| d < 1 ? last + d : d }
        .include?(nt.day)
    end

    def day_match?(nt)

      return weekday_match?(nt) || monthday_match?(nt) \
        if @weekdays && @monthdays
          #
          # From `man 5 crontab`
          #
          # Note: The day of a command's execution can be specified
          # by two fields -- day of month, and day of week.
          # If both fields are restricted (ie, are not *), the command will be
          # run when either field matches the current time.
          # For example, ``30 4 1,15 * 5'' would cause a command to be run
          # at 4:30 am on the 1st and 15th of each month, plus every Friday.
          #
          # as seen in gh-5 and gh-35

      return false unless weekday_match?(nt)
      return false unless monthday_match?(nt)

      true
    end

    def match?(t)

      t = Fugit.do_parse_at(t).translate(@timezone)

      month_match?(t) && day_match?(t) &&
      hour_match?(t) && min_match?(t) && sec_match?(t)
    end

    MAX_ITERATION_COUNT = 2048
      #
      # See gh-15 and tst/iteration_count.rb
      #
      # Initially set to 1024 after seeing the worst case for #next_time
      # at 167 iterations, I placed it at 2048 after experimenting with
      # gh-18 and noticing some > 1024 for some experiments. 2048 should
      # be ok.

    def next_time(from=::EtOrbi::EoTime.now)

      from = ::EtOrbi.make_time(from)
      sfrom = from.strftime('%F|%T')
      ifrom = from.to_i

      i = 0
      t = TimeCursor.new(self, from.translate(@timezone))
        #
        # the translation occurs in the timezone of
        # this Fugit::Cron instance

      zfrom = t.time.strftime('%z|%Z')

      loop do

        fail RuntimeError.new(
          "too many loops for #{@original.inspect} #next_time, breaking, " +
          "cron expression most likely invalid (Feb 30th like?), " +
          "please fill an issue at https://git.io/fjJC9"
        ) if (i += 1) > MAX_ITERATION_COUNT

        (ifrom == t.to_i) && (t.inc(1); next)
        month_match?(t) || (t.inc_month; next)
        day_match?(t) || (t.inc_day; next)
        hour_match?(t) || (t.inc_hour; next)
        min_match?(t) || (t.inc_min; next)
        sec_match?(t) || (t.inc_sec; next)

        tt = t.time
        st = tt.strftime('%F|%T')
        zt = tt.strftime('%z|%Z')
          #
        if st == sfrom && zt != zfrom
          from, sfrom, zfrom, ifrom = tt, st, zt, t.to_i
          next
        end
          #
          # when transitioning out of DST, this prevents #next_time from
          # yielding the same literal time twice in a row, see gh-6

        break
      end

      t.time.translate(from.zone)
        #
        # the answer time is in the same timezone as the `from`
        # starting point
    end

    def previous_time(from=::EtOrbi::EoTime.now)

      from = ::EtOrbi.make_time(from)

      i = 0
      t = TimeCursor.new(self, (from - 1).translate(@timezone))

      loop do

        fail RuntimeError.new(
          "too many loops for #{@original.inspect} #previous_time, breaking, " +
          "cron expression most likely invalid (Feb 30th like?), " +
          "please fill an issue at https://git.io/fjJCQ"
        ) if (i += 1) > MAX_ITERATION_COUNT

        month_match?(t) || (t.dec_month; next)
        day_match?(t) || (t.dec_day; next)
        hour_match?(t) || (t.dec_hour; next)
        min_match?(t) || (t.dec_min; next)
        sec_match?(t) || (t.dec_sec; next)
        break
      end

      t.time.translate(from.zone)
    end

    # Mostly used as a #next_time sanity check.
    # Avoid for "business" use, it's slow.
    #
    # 2017 is a non leap year (though it is preceded by
    # a leap second on 2016-12-31)
    #
    # Nota bene: cron with seconds are not supported.
    #
    def brute_frequency(year=2017)

      FREQUENCY_CACHE["#{to_cron_s}|#{year}"] ||=
        begin

          deltas = []

          t = EtOrbi.make_time("#{year}-01-01") - 1
          t0 = nil
          t1 = nil

          loop do
            t1 = next_time(t)
            deltas << (t1 - t).to_i if t0
            t0 ||= t1
            break if deltas.any? && t1.year > year
            break if t1.year - t0.year > 7
            t = t1
          end

          Frequency.new(deltas, t1 - t0)
        end
    end

    SLOTS = [
      [ :seconds, 1, 60 ],
      [ :minutes, 60, 60 ],
      [ :hours, 3600, 24 ],
      [ :days, 24 * 3600, 365 ] ]

    def rough_frequency

      slots = SLOTS
        .collect { |k, v0, v1|
          a = (k == :days) ? rough_days : instance_variable_get("@#{k}")
          [ k, v0, v1, a ] }

      slots.each do |k, v0, _, a|
        next if a == [ 0 ]
        break if a != nil
        return v0 if a == nil
      end

      slots.each do |k, v0, v1, a|
        next unless a && a.length > 1
        return (a + [ a.first + v1 ])
          .each_cons(2)
          .collect { |a0, a1| a1 - a0 }
          .select { |d| d > 0 } # weed out zero deltas
          .min * v0
      end

      slots.reverse.each do |k, v0, v1, a|
        return v0 * v1 if a && a.length == 1
      end

      1 # second
    end

    class Frequency

      attr_reader :span, :delta_min, :delta_max, :occurrences
      attr_reader :span_years, :yearly_occurrences

      def initialize(deltas, span)

        @span = span

        @delta_min = deltas.min; @delta_max = deltas.max
        @occurrences = deltas.size
        @span_years = span / (365 * 24 * 3600)
        @yearly_occurrences = @occurrences.to_f / @span_years
      end

      def to_debug_s

        {
          dmin: Fugit::Duration.new(delta_min).deflate.to_plain_s,
          dmax: Fugit::Duration.new(delta_max).deflate.to_plain_s,
          ocs: occurrences,
          spn: Fugit::Duration.new(span.to_i).deflate.to_plain_s,
          spnys: span_years.to_i,
          yocs: yearly_occurrences.to_i
        }.collect { |k, v| "#{k}: #{v}" }.join(', ')
      end
    end

    def to_a

      [ @seconds, @minutes, @hours, @monthdays, @months, @weekdays ]
    end

    def to_h

      { seconds: @seconds,
        minutes: @minutes,
        hours: @hours,
        monthdays: @monthdays,
        months: @months,
        weekdays: @weekdays }
    end

    def ==(o)

      o.is_a?(::Fugit::Cron) && o.to_a == to_a
    end
    alias eql? ==

    def hash

      to_a.hash
    end

    protected

    def compact_month_days

      return true if @months == nil || @monthdays == nil

      ms, ds =
        @months.inject([ [], [] ]) { |a, m|
          @monthdays.each { |d|
            next if d > MAXDAYS[m]
            a[0] << m; a[1] << d }
          a }
      @months = ms.uniq
      @monthdays = ds.uniq

      @months.any? && @monthdays.any?
    end

    def rough_days

      return nil if @weekdays == nil && @monthdays == nil

      months = (@months || (1..12).to_a)

      monthdays = months
        .product(@monthdays || [])
        .collect { |m, d|
          d = 31 + d if d < 0
          (m - 1) * 30 + d } # rough

      weekdays = (@weekdays || [])
        .collect { |d, w|
          w ?
          d + (w - 1) * 7 :
          (0..3).collect { |ww| d + ww * 7 } }
        .flatten
      weekdays = months
        .product(weekdays)
        .collect { |m, d| (m - 1) * 30 + d } # rough

      (monthdays + weekdays).sort
    end

    FREQUENCY_CACHE = {}

    def init(original, h)

      @original = original
      @cron_s = nil # just to be sure

      determine_seconds(h[:sec])
      determine_minutes(h[:min])
      determine_hours(h[:hou])
      determine_monthdays(h[:dom])
      determine_months(h[:mon])
      determine_weekdays(h[:dow])
      determine_timezone(h[:tz])

      return nil unless compact_month_days

      self
    end

    def expand(min, max, r)

      sta, edn, sla = r

      sla = nil if sla == 1 # don't get fooled by /1

      return [ nil ] if sta.nil? && edn.nil? && sla.nil?
      return [ sta ] if sta && edn.nil?

      sla = 1 if sla == nil
      sta = min if sta == nil
      edn = max if edn == nil

      range(min, max, sta, edn, sla)
    end

    def range(min, max, sta, edn, sla)

      fail ArgumentError.new(
        'both start and end must be negative in ' +
        { min: min, max: max, sta: sta, edn: edn, sla: sla }.inspect
      ) if (sta < 0 && edn > 0) || (edn < 0 && sta > 0)

#p({ min: min, max: max, sta: sta, edn: edn, sla: sla })
      a = []

      omin, omax = min, max
      min, max = -max, -1 if sta < 0
#p({ min: min, max: max })

      cur = sta

      loop do

        a << cur
        break if cur == edn

        cur += 1
        if cur > max
          cur = min
          edn = edn - max - 1 if edn > max
        end

        fail RuntimeError.new(
          "too many loops for " +
          { min: omin, max: omax, sta: sta, edn: edn, sla: sla }.inspect +
          " #range, breaking, " +
          "please fill an issue at https://git.io/fjJC9"
        ) if a.length > 2 * omax
          # there is a #uniq afterwards, hence the 2* for 0-24 and friends
      end

      a.each_with_index
        .select { |e, i| i % sla == 0 }
        .collect(&:first)
        .uniq
    end

    def compact(key)

      arr = instance_variable_get(key)

      return instance_variable_set(key, nil) if arr.include?(nil)
        # reductio ad astrum

      arr.uniq!
      arr.sort!
    end

    def determine_seconds(arr)
      @seconds = (arr || [ 0 ]).inject([]) { |a, s| a.concat(expand(0, 59, s)) }
      compact(:@seconds)
    end

    def determine_minutes(arr)
      @minutes = arr.inject([]) { |a, m| a.concat(expand(0, 59, m)) }
      compact(:@minutes)
    end

    def determine_hours(arr)
      @hours = arr
        .inject([]) { |a, h| a.concat(expand(0, 23, h)) }
        .collect { |h| h == 24 ? 0 : h }
      compact(:@hours)
    end

    def determine_monthdays(arr)
      @monthdays = arr.inject([]) { |a, d| a.concat(expand(1, 31, d)) }
      compact(:@monthdays)
    end

    def determine_months(arr)
      @months = arr.inject([]) { |a, m| a.concat(expand(1, 12, m)) }
      compact(:@months)
    end

    def determine_weekdays(arr)

      @weekdays = []

      arr.each do |a, z, sl, ha, mo| # a to z, slash, hash, and mod
        if ha || mo
          @weekdays << [ a, ha || mo ]
        elsif sl
          ((a || 0)..(z || (a ? a : 6))).step(sl < 1 ? 1 : sl)
            .each { |i| @weekdays << [ i ] }
        elsif z
          z = z + 7 if a > z
          (a..z).each { |i| @weekdays << [ (i > 6) ? i - 7 : i ] }
        elsif a
          @weekdays << [ a ]
        #else
        end
      end

      @weekdays.each { |wd| wd[0] = 0 if wd[0] == 7 } # turn sun7 into sun0
      @weekdays.uniq!
      @weekdays.sort!
      @weekdays = nil if @weekdays.empty?
    end

    def determine_timezone(z)

      @zone, @timezone = z
    end

    module Parser include Raabro

      WEEKDAYS = %w[ sunday monday tuesday wednesday thursday friday saturday ]
      WEEKDS = WEEKDAYS.collect { |d| d[0, 3] }

      MONTHS = %w[ - jan feb mar apr may jun jul aug sep oct nov dec ]

      # piece parsers bottom to top

      def s(i); rex(nil, i, /[ \t]+/); end
      def star(i); str(nil, i, '*'); end
      def hyphen(i); str(nil, i, '-'); end
      def comma(i); str(nil, i, ','); end

      def slash(i); rex(:slash, i, /\/\d\d?/); end

      def mos(i); rex(:mos, i, /[0-5]?\d/); end # min or sec
      def hou(i); rex(:hou, i, /(2[0-4]|[01]?[0-9])/); end
      def dom(i); rex(:dom, i, /(-?(3[01]|[12][0-9]|0?[1-9])|last|l)/i); end
      def mon(i); rex(:mon, i, /(1[0-2]|0?[1-9]|#{MONTHS[1..-1].join('|')})/i); end
      def dow(i); rex(:dow, i, /([0-7]|#{WEEKDS.join('|')})/i); end

      def dow_hash(i); rex(:hash, i, /#(-?[1-5]|last|l)/i); end

      def _mos(i); seq(nil, i, :hyphen, :mos); end
      def _hou(i); seq(nil, i, :hyphen, :hou); end
      def _dom(i); seq(nil, i, :hyphen, :dom); end
      def _mon(i); seq(nil, i, :hyphen, :mon); end
      def _dow(i); seq(nil, i, :hyphen, :dow); end

      # r: range
      def r_mos(i); seq(nil, i, :mos, :_mos, '?'); end
      def r_hou(i); seq(nil, i, :hou, :_hou, '?'); end
      def r_dom(i); seq(nil, i, :dom, :_dom, '?'); end
      def r_mon(i); seq(nil, i, :mon, :_mon, '?'); end
      def r_dow(i); seq(nil, i, :dow, :_dow, '?'); end

      # sor: star or range
      def sor_mos(i); alt(nil, i, :star, :r_mos); end
      def sor_hou(i); alt(nil, i, :star, :r_hou); end
      def sor_dom(i); alt(nil, i, :star, :r_dom); end
      def sor_mon(i); alt(nil, i, :star, :r_mon); end
      def sor_dow(i); alt(nil, i, :star, :r_dow); end

      # sorws: star or range with[out] slash
      def sorws_mos(i); seq(nil, i, :sor_mos, :slash, '?'); end
      def sorws_hou(i); seq(nil, i, :sor_hou, :slash, '?'); end
      def sorws_dom(i); seq(nil, i, :sor_dom, :slash, '?'); end
      def sorws_mon(i); seq(nil, i, :sor_mon, :slash, '?'); end
      def sorws_dow(i); seq(nil, i, :sor_dow, :slash, '?'); end

      # ssws: slash or sorws
      def mos_elt(i); alt(:elt, i, :slash, :sorws_mos); end
      def hou_elt(i); alt(:elt, i, :slash, :sorws_hou); end
      def dom_elt(i); alt(:elt, i, :slash, :sorws_dom); end
      def mon_elt(i); alt(:elt, i, :slash, :sorws_mon); end
      def dow_elt(i); alt(:elt, i, :slash, :sorws_dow); end

      def mod(i); rex(:mod, i, /%\d+(\+\d+)?/); end

      def mod_dow(i); seq(:elt, i, :dow, :mod); end
      def h_dow(i); seq(:elt, i, :dow, :dow_hash); end

      def dow_elt_(i); alt(nil, i, :h_dow, :mod_dow, :dow_elt); end

      def list_sec(i); jseq(:sec, i, :mos_elt, :comma); end
      def list_min(i); jseq(:min, i, :mos_elt, :comma); end
      def list_hou(i); jseq(:hou, i, :hou_elt, :comma); end
      def list_dom(i); jseq(:dom, i, :dom_elt, :comma); end
      def list_mon(i); jseq(:mon, i, :mon_elt, :comma); end
      def list_dow(i); jseq(:dow, i, :dow_elt_, :comma); end

      def lsec_(i); seq(nil, i, :list_sec, :s); end
      def lmin_(i); seq(nil, i, :list_min, :s); end
      def lhou_(i); seq(nil, i, :list_hou, :s); end
      def ldom_(i); seq(nil, i, :list_dom, :s); end
      def lmon_(i); seq(nil, i, :list_mon, :s); end
      alias ldow list_dow

      def _tz_name(i)
        rex(nil, i, / +[A-Z][a-zA-Z0-9+\-]+(\/[A-Z][a-zA-Z0-9+\-_]+){0,2}/)
      end
      def _tz_delta(i)
        rex(nil, i, / +[-+]([01][0-9]|2[0-4]):?(00|15|30|45)/)
      end
      def _tz(i); alt(:tz, i, :_tz_delta, :_tz_name); end

      def classic_cron(i)
        seq(:ccron, i, :lmin_, :lhou_, :ldom_, :lmon_, :ldow, :_tz, '?')
      end
      def second_cron(i)
        seq(:scron, i, :lsec_, :lmin_, :lhou_, :ldom_, :lmon_, :ldow, :_tz, '?')
      end

      def cron(i)
        alt(:cron, i, :second_cron, :classic_cron)
      end

      # rewriting the parsed tree

      def rewrite_bound(k, t)

        s = t.string.downcase

        (k == :mon && MONTHS.index(s)) ||
        (k == :dow && WEEKDS.index(s)) ||
        ((k == :dom) && s[0, 1] == 'l' && -1) || # L, l, last
        s.to_i
      end

      def rewrite_mod(k, t)

        mod, plus = t.string
          .split(/[%+]/).reject(&:empty?).collect(&:to_i)

        [ mod, plus || 0 ]
      end

      def rewrite_elt(k, t)

        at, zt, slt, hat, mot = nil; t.subgather(nil).each do |tt|
          case tt.name
          when :slash then slt = tt
          when :hash then hat = tt
          when :mod then mot = tt
          else if at; zt ||= tt; else; at = tt; end
          end
        end

        sl = slt ? slt.string[1..-1].to_i : nil

        ha = hat ? hat.string[1..-1] : nil
        ha = -1 if ha && ha.upcase[0, 1] == 'L'
        ha = ha.to_i if ha

        mo = mot ? rewrite_mod(k, mot) : nil

        a = at ? rewrite_bound(k, at) : nil
        z = zt ? rewrite_bound(k, zt) : nil

        #a, z = z, a if a && z && a > z
          # handled downstream since gh-27

        [ a, z, sl, ha, mo ]
      end

      def rewrite_entry(t)

        t
          .subgather(:elt)
          .collect { |et| rewrite_elt(t.name, et) }
      end

      def rewrite_tz(t)

        s = t.strim
        z = EtOrbi.get_tzone(s)

        [ s, z ]
      end

      def rewrite_cron(t)

        hcron = t
          .sublookup(nil) # go to :ccron or :scron
          .subgather(nil) # list min, hou, mon, ...
          .inject({}) { |h, tt|
            h[tt.name] = tt.name == :tz ? rewrite_tz(tt) : rewrite_entry(tt)
            h }

        z, tz = hcron[:tz]; return nil if z && ! tz

        hcron
      end
    end
  end
end

