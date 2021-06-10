# Implementation of the `crystal repl` command

class Crystal::Command
  private def repl
    decompile = false
    trace = false
    stats = false

    OptionParser.parse(options) do |opts|
      opts.banner = "Usage: crystal repl [options] [files]\n\nOptions:"

      opts.on("-d", "--decompile", "Show decompilation") do
        decompile = true
      end

      opts.on("-s", "--status", "Show time taken to execute") do
        stats = true
      end

      opts.on("-t", "--trace", "Trace execution") do
        trace = true
      end

      opts.on("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    repl = Repl.new(
      decompile: decompile,
      decompile_defs: false,
      trace: trace,
      stats: stats,
    )

    options.each do |filename|
      repl.load_and_interpret_file(filename)
    end

    repl.run
  end
end
