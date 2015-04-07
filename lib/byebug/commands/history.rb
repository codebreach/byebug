require 'byebug/command'
require 'byebug/helpers/parse'

module Byebug
  #
  # Show history of byebug commands.
  #
  class HistoryCommand < Command
    include Helpers::ParseHelper

    def regexp
      /^\s* hist(?:ory)? (?:\s+(?<num_cmds>.+))? \s*$/x
    end

    def execute
      history = @state.interface.history

      if @match[:num_cmds]
        size, _ = get_int(@match[:num_cmds], 'history', 1, history.size)
        return errmsg(err) unless size
      end

      puts history.to_s(size)
    end

    def description
      <<-EOD
        hist[ory] [num_cmds]

        Show byebug's command history.
      EOD
    end
  end
end
