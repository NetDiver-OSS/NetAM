# frozen_string_literal: true
module Hamlit
  class Compiler
    class CommentCompiler
      def compile(node, &block)
        if node.value[:conditional]
          compile_conditional_comment(node, &block)
        else
          compile_html_comment(node, &block)
        end
      end

      private

      def compile_html_comment(node, &block)
        if node.children.empty?
          [:html, :comment, [:static, " #{node.value[:text]} "]]
        else
          [:html, :comment, yield(node)]
        end
      end

      def compile_conditional_comment(node, &block)
        condition = node.value[:conditional]
        if node.value[:conditional] =~ /\A\[(\[*[^\[\]]+\]*)\]/
          condition = $1
        end

        content =
          if node.children.empty?
            [:static, " #{node.value[:text]} "]
          else
            yield(node)
          end
        [:html, :condcomment, condition, content, node.value[:revealed]]
      end
    end
  end
end
