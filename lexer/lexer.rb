require_relative "../token/token"

class Lexer
  def initialize(input)
    @input = input
    @position = 0
    @read_position = 0
    @ch = ""

    read_char
  end

  def next_token
    skip_whitespace

    case @ch
      when '='
        tok = Token.new(Token::ASSIGN, @ch)
        read_char
      when ';'
        tok = Token.new(Token::SEMICOLON, @ch)
        read_char
      when '('
        tok = Token.new(Token::LPAREN, @ch)
        read_char
      when ')'
        tok = Token.new(Token::RPAREN, @ch)
        read_char
      when ','
        tok = Token.new(Token::COMMA, @ch)
        read_char
      when '+'
        tok = Token.new(Token::PLUS, @ch)
        read_char
      when '{'
        tok = Token.new(Token::LBRACE, @ch)
        read_char
      when '}'
        tok = Token.new(Token::RBRACE, @ch)
        read_char
      when nil
        tok = Token.new(Token::EOF, @ch)
      else
        if is_letter(@ch)
          literal = read_identifier
          tok = Token.new(
            Token.look_up_ident(literal),
            literal
          )
        elsif is_digit(@ch)
          literal = read_number
          tok = Token.new(Token::INT, literal)
        else
          tok = Token.new(Token::ILLEGAL, @ch)
          read_char
        end
    end

    tok
  end

  private

  def is_letter(ch)
    ch =~ /[a-zA-Z_]/
  end

  def read_char
    if @read_position >= @input.length
      @ch = nil

    else
      @ch = @input[@read_position]
    end

    @position = @read_position
    @read_position += 1
  end

  def skip_whitespace
    while @ch == ' ' || @ch == "\t" || @ch == "\n" || @ch == "\r"
      read_char
    end
  end

  def read_identifier
    position = @position
    while is_letter(@ch)
      read_char
    end
    @input[position...@position]
  end

  def read_number
    position = @position
    while @ch =~ /[0-9]/
      read_char
    end
    @input[position...@position]
  end

  def is_digit(ch)
    ch =~ /[0-9]/
  end
end
