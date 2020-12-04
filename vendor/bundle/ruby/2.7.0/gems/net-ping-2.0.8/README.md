# net-ping
A collection of classes that provide different ways to ping computers.

## Prerequisites
  * ffi
  * win32-security (MS Windows only)
  * fakeweb (test only)
  * test-unit (test only)

  Ruby users should use Ruby 1.9.3 or later.
  JRuby users should use JRuby 1.6.7 or later.

## Installation
  ```gem install net-ping```

## Notes
  Please read the documentation under the 'doc' directory. Especially pay
  attention to the documentation pertaining to ECONNREFUSED and TCP pings.

  Also note the documentation regarding down hosts.

## How to require net-ping
  You can do either this:

  ```require 'net/ping'```

  In which case you will get Net::Ping and all of its subclasses. Or,
  you can load individual subclasses like this:

  ```require 'net/ping/tcp'```

  The former has the advantage of being easier to remember and all inclusive,
  not to mention backwards compatible. The latter has the advantage of
  reducing your memory footprint.

## Known Issues
  Older versions of Ruby 1.9.x may not work with UDP pings.

  Older versions of JRuby will return false positives in UDP pings
  because of an incorrect error class being raised. See JRuby-4896.

  JRuby 1.6.7 or later is required for external pings because of a bug
  in earlier versions with open3 and stream handling.

  ICMP pings will not work with JRuby without some sort of third-party
  library support for raw sockets in Java, such as RockSaw.

## License
  Artistic 2.0

## Contributions
  Although this library is free, please consider having your company
  setup a gittip if used by your company professionally.

  http://www.gittip.com/djberg96/

## More documentation
  If you installed this library via Rubygems, you can view the inline
  documentation via ri or fire up 'gem server', and point your browser at
  http://localhost:8808.

## Author
  Daniel J. Berger
