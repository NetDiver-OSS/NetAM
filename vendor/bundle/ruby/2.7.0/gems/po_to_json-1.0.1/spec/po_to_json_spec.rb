# -*- coding: UTF-8 -*-
#
# Copyright (c) 2012-2015 Dropmysite.com <https://dropmyemail.com>
# Copyright (c) 2015 Webhippie <http://www.webhippie.de>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require "spec_helper"

describe PoToJson do
  let(:po_to_json) do
    @subject = PoToJson.new(
      File.expand_path("../fixtures/test.po", __FILE__)
    )
  end

  describe "parsing" do
    subject do
      po_to_json.parse_document
    end

    it "should find the last author" do
      expect(subject[""]["Last-Translator"]).to(
        eq("FULL NAME <EMAIL@ADDRESS>")
      )
    end

    it "should parse embedded variables" do
      expect(subject["%{relative_time} ago"]).to(
        eq(["vor %{relative_time}"])
      )
    end

    it "should match pluralizations" do
      expect(subject["1 Axis"]).to(
        eq(["1 Achse", "%{num} Achsen"])
      )
    end

    it "should match glued values" do
      expect(subject["Car|Model"]).to(
        eq(["Modell"])
      )
    end

    it "should match embedded glue" do
      expect(subject["Car|Wheels count"]).to(
        eq(["Räderzahl"])
      )
    end

    it "should return empty strings as well" do
      expect(subject["Untranslated"]).to(
        eq([""])
      )
    end

    it "should match german umlauts" do
      expect(subject["Umläüte"]).to(
        eq(["Umlaute"])
      )
    end

    it "should match escaped values" do
      expect(subject["You should escape '\\\\' as '\\\\\\\\'."]).to(
        eq(["Du solltest '\\\\' als '\\\\\\\\' escapen."])
      )
    end

    it "should match multiline translations" do
      expect(subject["this is a dynamic translation which was found!"]).to(
        eq(["Dies ist eine dynamische Übersetzung, die gefunden wurde!"])
      )
    end

    it "should match simple strings" do
      expect(subject["Car was successfully created."]).to(
        eq(["Auto wurde erfolgreich gespeichert"])
      )

      expect(subject["Car was successfully updated."]).to(
        eq(["Auto wurde erfolgreich aktualisiert"])
      )

      expect(subject["Created"]).to(
        eq(["Erstellt"])
      )

      expect(subject["Month"]).to(
        eq(["Monat"])
      )

      expect(subject["car"]).to(
        eq(["Auto"])
      )
    end
  end

  describe "generate jed compatible" do
    describe "with minified output" do
      subject do
        po_to_json.generate_for_jed("de")
      end

      it "should output the var definition" do
        expect(
          subject.include?("var locales = locales || {}; locales['de'] = ")
        ).to be_truthy
      end

      it "should include domain string" do
        expect(
          subject.include?('"domain":"app"')
        ).to be_truthy
      end

      it "should include lang string" do
        expect(
          subject.include?('"lang":"de"')
        ).to be_truthy
      end

      it "should include pluralization" do
        val = '"plural_forms":"nplurals=2; plural=(n != 1);"'
        expect(
          subject.include? val
        ).to be_truthy
      end

      it "should include a single line break" do
        expect(
          subject.count("\n")
        ).to be < 1
      end
    end

    context "with pretty output" do
      subject do
        po_to_json.generate_for_jed("de", pretty: true)
      end

      it "should output the var definition" do
        expect(
          subject.include?("var locales = locales || {}; locales['de'] = ")
        ).to be_truthy
      end

      it "should include domain string" do
        expect(
          subject.include?('"domain": "app"')
        ).to be_truthy
      end

      it "should include lang string" do
        expect(
          subject.include?('"lang": "de"')
        ).to be_truthy
      end

      it "should include pluralization" do
        val = '"plural_forms": "nplurals=2; plural=(n != 1);"'
        expect(
          subject.include? val
        ).to be_truthy
      end

      it "should include multiple line breaks" do
        expect(
          subject.count("\n")
        ).to be > 0
      end
    end
  end

  # describe "generate simple hashes" do
  #   pending "have to be implemented"
  # end
end
