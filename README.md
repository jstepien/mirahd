mirahd
======

**mirahd** is a Mirah Daemon listening for your requests to compile something.
When it receives one it does the job quickly. _Really quickly_.

Usage
-----

We'll need:

  * Bundler,
  * Mirah, and as a result
  * JRuby 1.6.

For your own comfort and sanity it is also advisable to install a Ruby
implementation with a reasonably short start up time. MRI or Rubinius
are good candidates.

    jruby -S bundle install
    jruby -S rspec test
    jruby -rubygems -I lib -S bin/mirahd --daemon
    ruby -I lib bin/mirahd test/hello.mirah

Rationale
---------

Mirah is a lovely language but its low compilation speed might be discouraging.
Using it in development based on a lot of small _code, test, refactor_ cycles
might be problematic. JVM's start up time and a lag introduced by compilation
of Mirah's sources by JRuby add up to the sum we see below¹.

    $ time mirahc test/hello.mirah > /dev/null # with disk's cache warmed up
    18.60user 0.45system 0:11.85elapsed

After the initial warm up JVM and JRuby are pretty fast. The goal of this
project is to make the JVM start once only and then reuse the existing process
for all subsequent compilation tasks.

Run the daemon.

    $ jruby -rubygems -I lib -S bin/mirahd --daemon

The first compilation is already quite quick.

    $ time ruby -I lib -S bin/mirahd test/hello.mirah
    0.05user 0.00system 0:00.89elapsed

Then JVM's JIT comes into play. Here's the tenth compilation.

    $ time ruby -I lib -S bin/mirahd test/hello.mirah
    0.04user 0.00system 0:00.30elapsed

Todo
----

  * Security. By being able to access the port DRb is listening on you
    can `eval` whatever you want to. `$SAFE` won't work as it's unsupported
    by JRuby.
  * Enable users to specify the port number.
  * Redirect compiler's standard output and error to the client.
  * Write tests covering a server running in a different directory then the
    client. It won't be possible without spawning 2 separate processes.
  * Support `--help` et al. command line arguments.
  * Concurrency. Two compilation requests might interfere with each other,
    especially due to changing the current working directory.

Copyrights
----------

Copyright (c) 2012 Jan Stępień

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

___
¹ That's a 64-bit OpenJDK 6 on Intel Core 2 Duo with GNU/Linux 3.2.8.
