module Pkgdown

using Markdown

include("quarto_format.jl");
export QuartoDoc,
    get_docstring_content,
    quarto_format,
    @qdoc;

include("build.jl");
export quarto_yaml,
    quarto_index,
    quarto_build_site;

end # module Pkgdown