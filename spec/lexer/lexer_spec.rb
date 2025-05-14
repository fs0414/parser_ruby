require "spec_helper"
require_relative "../../lexer/lexer.rb"
require_relative "../../token/token.rb"
require 'debug'

describe Lexer do

  it "tokenizes the input string correctly" do
    input = "=+(){},;"

    expected_tokens = [
      { type: Token::ASSIGN,    literal: "=" },
      { type: Token::PLUS,      literal: "+" },
      { type: Token::LPAREN,    literal: "(" },
      { type: Token::RPAREN,    literal: ")" },
      { type: Token::LBRACE,    literal: "{" },
      { type: Token::RBRACE,    literal: "}" },
      { type: Token::COMMA,     literal: "," },
      { type: Token::SEMICOLON, literal: ";" },
      { type: Token::EOF,       literal: nil }
    ]

    lexer = Lexer.new(input)

    expected_tokens.each_with_index do |expected, i|
      actual_token = lexer.nextToken

      binding.break
      expect(actual_token.type).to eq(expected[:type]),
        "Test case #{i + 1}: Token type mismatch. Expected '#{expected[:type]}', got '#{actual_token.type}'"
      expect(actual_token.literal).to eq(expected[:literal]),
        "Test case #{i + 1}: Token literal mismatch. Expected '#{expected[:literal]}', got '#{actual_token.literal}'"
    end
  end
end
