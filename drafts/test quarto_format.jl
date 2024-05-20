using Markdown
using Pkgdown;

# formatting
z = @doc maximum;

ds = get_docstring_content(z)

m = ds[1]
m.code
m.language


for d ∈ ds
    quarto_format(d) |> println    
end

# testing

quarto_format(m) |> print
quarto_format(c[3]) |> print
quarto_format(c[4]) |> print



m = ds[5]
ds[6]
quarto_format(m) |> print

zz = map(ds) do d
    quarto_format(d)    
end

string(zz...) |> print

d = @doc(sin)
d.content

f = sin

ds = @qdoc sin
ds |> println

names(Pkgdown)

# quarto_doc_page

f_symbol = :findall
f_string = string(f_symbol)
f = eval(f_symbol)
Base.doc(f)

z.content[1].content[1].content .|> Markdown.plain

docs = @qdoc findall

doc_page = """
---
engine: julia
---

# $(string(ss))

$docs

"""

quarto_yaml("Pkgdown")

s = names(Pkgdown)[6]
s = :quarto_format

s = :findall

f = @eval $s

z = Base.doc(f)

doc_methods = z.content

doc_method = doc_methods[1].content[1].content

quarto_format.(doc_method)

Markdown.plain(doc_method)

f = @eval $(:sin)

Base.doc(@eval $(:max))

f = :sin

function str_concat(a, b; sep = "\n")
    a * sep * b
end

function str_concat(v; sep = "\n")
    reduce((a, b) -> str_concat(a, b, sep = sep), v)
end

function qdoc(f)
    z = Base.doc(@eval $(f))

    doc_methods = z.content

    ms = map(doc_methods) do m
        doc_method = m.content[1].content
        quarto_format.(doc_method)
    end    

    blocks = map(ms) do m
        str_concat(m)
    end

    blocks
end

function quarto_doc_page(s)

    blocks = qdoc(s) .|> quarto_callout_block

    qmd = 
    """
---
engine: julia
---

# $(string(s))
    
$(str_concat(blocks, sep = "\n --- \n "))
"""
    path = "docs/from_module/$(string(s)).qmd"
    @info "Writing docs to file $path"
    write(path, qmd)
end

function quarto_callout_block(s)

"""

::: {.callout-note appearance="simple"}

## docblock

$s

:::
    
"""
end

s = :sin

fs = [:sin, :cos, :tan, :mod, :div, :findall, :findfirst, :findprev]

quarto_doc_page.(fs)

quarto_doc_page(:sin)