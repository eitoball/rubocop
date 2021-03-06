# encoding: utf-8

module Rubocop
  module Cop
    module Style
      # This cop checks for the use of a method, the result of which
      # would be a literal, like an empty array, hash or string.
      class EmptyLiteral < Cop
        ARR_MSG = 'Use array literal [] instead of Array.new.'
        HASH_MSG = 'Use hash literal {} instead of Hash.new.'
        STR_MSG = "Use string literal '' instead of String.new."

        # Empty array node
        #
        # (send
        #   (const nil :Array) :new)
        ARRAY_NODE = s(:send, s(:const, nil, :Array), :new)

        # Empty hash node
        #
        # (send
        #   (const nil :Hash) :new)
        HASH_NODE = s(:send, s(:const, nil, :Hash), :new)

        # Empty string node
        #
        # (send
        #   (const nil :String) :new)
        STR_NODE = s(:send, s(:const, nil, :String), :new)

        def on_send(node)
          case node
          when ARRAY_NODE
            add_offence(:convention,
                        node.loc.expression,
                        ARR_MSG)
          when HASH_NODE
            add_offence(:convention,
                        node.loc.expression,
                        HASH_MSG)
          when STR_NODE
            add_offence(:convention,
                        node.loc.expression,
                        STR_MSG)
          end
        end

        # TODO Check block contents as well
        alias_method :on_block, :ignore_node
      end
    end
  end
end
