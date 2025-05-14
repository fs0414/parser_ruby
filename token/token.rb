class Token
  attr_reader :type, :literal
  def initialize(type, literal)
    @type = type
    @literal = literal
  end

  ILLEGAL = "ILLEGAL"
	EOF     = "EOF"
	IDENT = "IDENT"
	INT   = "INT"
	ASSIGN = "="
	PLUS   = "+"
	COMMA  = ","
	SEMICOLON = ";"
	LPAREN = "("
	RPAREN = ")"
	LBRACE = "{"
	RBRACE = "}"
	FUNCTION = "FUNCTION"
	LET      = "LET"
end
