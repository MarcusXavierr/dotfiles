# find . -name '*' -exec file {} \; \ # percorre todos os arquivos recursivamente e roda o comando file em cada um, lá tem o tipo do arquivo
#     | grep -o -P '^.+: \w+ image' \ # filtra somente os arquivos que tem o pattern de `image`
#     | awk '{print $1}' \ # pega somente o nome do arquivo (que está junto a um `:`)
#     | sed 's/.$//' # remove esse `:` do final do nome do arquivo


# Explanation above
find_all_images () {
    find . -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image' | awk '{print $1}' | sed 's/.$//'
}

# fdfind  # busca os seus arquivos recursivamente e de forma inteligente (ignorando .git e node_modules, etc)
#     | xargs -L1 wc -l  # pegará a saída e rodará o comando wc -l {} em cima disso, que vai trazer a quantidade de linhas e o path
#     | sort -rn # vai ordenar a pela quantidade de linhas
#     | less # vai mostrar no less que é melhor

count_line_files () {
    fdfind | xargs -L1 wc -l  | sort -rn | less
}
