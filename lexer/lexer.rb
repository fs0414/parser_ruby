require_relative "../token/token"
require "debug"

class Lexer
  def initialize(input)
    @input = input
    @position = 0
    @read_position = 0
    @ch = ""

    readChar
  end

  def readChar
    if @read_position >= @input.length
      @ch = nil
    else
      @ch = @input[@read_position]
    end

    @read_position += 1
    @position += 1
  end

  def nextToken
    tok = nil
    case @ch
    when '='
      tok = Token.new(Token::ASSIGN, @ch)
    when ';'
      tok = Token.new(Token::SEMICOLON, @ch)
    when '('
      tok = Token.new(Token::LPAREN, @ch)
    when ')'
      tok = Token.new(Token::RPAREN, @ch)
    when ','
      tok = Token.new(Token::COMMA, @ch)
    when '+'
      tok = Token.new(Token::PLUS, @ch)
    when '{'
      tok = Token.new(Token::LBRACE, @ch)
    when '}'
      tok = Token.new(Token::RBRACE, @ch)
    when nil 
      tok = Token.new(Token::EOF, @ch)
    else
      if @ch.nil?
        binding.break
        tok = Token.new(Token::EOF, @ch)
      else
        tok = Token.new(Token::ILLEGAL, @ch)
      end
    end

    readChar
    tok
  end
end
