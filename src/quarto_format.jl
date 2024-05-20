# types
@kwdef mutable struct QuartoDoc
    Call = nothing,
    Description = nothing,
    Arguments = nothing,
    Returns = nothing,
    Details = nothing,
    Example = nothing,
    Examples = nothing
end

# formatting
get_docstring_content(z) = z.content[1].content[1].content;

function quarto_format(m::Markdown.Code, eval = false)

    l = m.language        
    l ∈ ["jldoctest", ""] && (l = "julia")
        
"""

```{$l}
#| eval: $eval
$(m.code)

```

"""
end

quarto_format(m) = Markdown.plain(m)

quarto_format(m::Markdown.Paragraph) = Markdown.plain(m) * " \n"

quarto_format(m::AbstractString) = m

function quarto_format(m::Markdown.Header{1})
"""

### $(m.text[1])
    
"""
    end

# macros
macro qdoc(f)
    
    ds1 = quote
        @doc $f ;
    end

    ds = get_docstring_content(eval(ds1))
    s = quarto_format.(ds)
        
    string(s...)    
end