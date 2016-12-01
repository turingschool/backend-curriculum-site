module TemplateWrapper
  # Wrap input with a <div>
  def self.safe_wrap(input)
    "<div class='bogus-wrapper'><notextile>#{input}</notextile></div>"
  end
  # This must be applied after the
  def self.unwrap(input)
    input.gsub /<div class=['"]bogus-wrapper['"]><notextile>(.+?)<\/notextile><\/div>/m do
      $1
    end
  end
end

module Jekyll

  class TerminalTag < Liquid::Block
    include TemplateWrapper

    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      output = super(context)

      %{<div class="window">
          <nav class="control-window">
            <a href="#finder" class="close" data-rel="close">close</a>
            <a href="#" class="minimize">minimize</a>
            <a href="#" class="maximize">maximize</a>
          </nav>
          <h1 class="titleInside">Terminal</h1>
          <div class="terminal-container"><div class="terminal">#{promptize(output)}</div></div>
        </div>}
    end

    def promptize(content)
      content = content.strip
      gutters = content.lines.map { |line| gutter(line) }
      lines_of_code = content.lines.map { |line| line_of_code(line) }

      table = "<table><tr>"
      table += "<td class='gutter'><pre class='line-numbers'>#{gutters.join("\n")}</pre></td>"
      table += "<td class='code'><pre><code>#{lines_of_code.join("")}</code></pre></td>"
      table += "</tr></table>"
    end

    def gutter(line)
      gutter_value = line.start_with?(command_character) ? command_character : "&nbsp;"
      "<span class='line-number'>#{gutter_value}</span>"
    end

    def line_of_code(line)
      if line.start_with?(command_character)
        line_class = "command"
        line = line.sub(command_character,'').strip
      else
        line_class = "output"
      end
      "<span class='line #{line_class}'>#{line}</span>"
    end

    def command_character
      "$"
    end

  end

end

Liquid::Template.register_tag('terminal', Jekyll::TerminalTag)
