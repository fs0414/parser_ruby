require_relative '../spec_helper'
require_relative "../../lexer/lexer"
require_relative "../../token/token"

describe Lexer do
  it "tokenizes the input string correctly" do
    input = "
      let fire = 5;
      let ten = 10;
      let add = fn(x, y) {
        x + y;
      };
      let result = add(fire, ten);
    "

    expected_tokens = [
      { type: Token::LET,       literal: "let" },
      { type: Token::IDENT,     literal: "fire" },
      { type: Token::ASSIGN,    literal: "=" },
      { type: Token::INT,       literal: "5" },
      { type: Token::SEMICOLON, literal: ";" },
      { type: Token::LET,       literal: "let" },
      { type: Token::IDENT,     literal: "ten" },
      { type: Token::ASSIGN,    literal: "=" },
      { type: Token::INT,       literal: "10" },
      { type: Token::SEMICOLON, literal: ";" },
      { type: Token::LET,       literal: "let" },
      { type: Token::IDENT,     literal: "add" },
      { type: Token::ASSIGN,    literal: "=" },
      { type: Token::FUNCTION,  literal: "fn" },
      { type: Token::LPAREN,    literal: "(" },
      { type: Token::IDENT,     literal: "x" },
      { type: Token::COMMA,     literal: "," },
      { type: Token::IDENT,     literal: "y" },
      { type: Token::RPAREN,    literal: ")" },
      { type: Token::LBRACE,    literal: "{" },
      { type: Token::IDENT,     literal: "x" },
      { type: Token::PLUS,      literal: "+" },
      { type: Token::IDENT,     literal: "y" },
      { type: Token::SEMICOLON, literal: ";" },
      { type: Token::RBRACE,    literal: "}" },
      { type: Token::SEMICOLON, literal: ";" },
      { type: Token::LET,       literal: "let" },
      { type: Token::IDENT,     literal: "result" },
      { type: Token::ASSIGN,    literal: "=" },
      { type: Token::IDENT,     literal: "add" },
      { type: Token::LPAREN,    literal: "(" },
      { type: Token::IDENT,     literal: "fire" },
      { type: Token::COMMA,     literal: "," },
      { type: Token::IDENT,     literal: "ten" },
      { type: Token::RPAREN,    literal: ")" },
      { type: Token::SEMICOLON, literal: ";" },
      { type: Token::EOF,       literal: nil }
    ]

    lexer = Lexer.new(input)

    expected_tokens.each_with_index do |expected, i|
      actual_token = lexer.next_token

      # binding.break
      expect(actual_token.type).to eq(expected[:type]),
        "Test case #{i + 1}: Token type mismatch. Expected '#{expected[:type]}', got '#{actual_token.type}'"
      expect(actual_token.literal).to eq(expected[:literal]),
        "Test case #{i + 1}: Token literal mismatch. Expected '#{expected[:literal]}', got '#{actual_token.literal}'"
    end
  end

  describe "#is_letter" do
    let("lexer") { Lexer.new("") }

    it "input a true" do
      expect(lexer.send(:is_letter, 'a')).to be  0
    end
    it "input 1 false" do
      expect(lexer.send(:is_letter, '1')).to be  nil
    end
  end
end
