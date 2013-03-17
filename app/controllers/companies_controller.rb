#encoding: utf-8
class CompaniesController < ApplicationController

  def index
    @top_companies = [
      # É CHUMBO GROSSO!
      { name: 'LG',         count: 4705  },
      { name: 'Oi',         count: 5757  },
      { name: 'Claro',      count: 18614 },
      { name: 'Brastemp',   count: 15347 },
      { name: 'Samsung',    count: 1488  },
      { name: 'Tim',        count: 18415 },
      { name: 'Ponto Frio', count: 13022 },
      { name: 'Vivo',       count: 9240  },
      { name: 'GVT',        count: 17868 },
      { name: 'Americanas', count: 15695 },
      { name: 'Submarino',  count: 18988 },
      { name: 'Volkswagen', count: 18558 },
      { name: 'Ford',       count: 1057  },
      { name: 'Peugeot',    count: 17555 },
      { name: 'Rossi',      count: 20726 },
      { name: 'Sony',       count: 15905 },
      { name: 'Gradiente',  count: 584   },
      { name: 'Apple',      count: 8077  },
      { name: 'HP',         count: 18101 },
      { name: 'Philips',    count: 11587 },
      { name: 'Epson',      count: 3342  }
    ].sort_by {|company| company[:count] * -1 }
    @nav_links = nav_links
  end

  def show
    @company  = Company.where(strNomeFantasia: params[:nome].upcase).first
    @complaints_by_type = Hash[group(@company.complaints).sort.reverse]
    @regions  = regions
    @states   = @company.complaints_by_region

    @nav_links = nav_links
  end

  def group(complaints)
    # MAP REDUCE MTF! DO YOU USE IT?
    # SAY WHATTTTT??
    # SAY WHAT ONE MORE TIME. I DARE YOU.
    # I DOUBLE DARE YOU!
    complaints.group_by {|compl| compl.CodigoProblema }
  end

  def regions
    { "AC" => ["Acre"                , "A"],
      "AL" => ["Alagoas"             , "B"],
      "AP" => ["Amapá"               , "C"],
      "AM" => ["Amazonas"            , "D"],
      "BA" => ["Bahia"               , "E"],
      "CE" => ["Ceará"               , "F"],
      "DF" => ["Distrito Federal"    , "G"],
      "ES" => ["Espírito Santo"      , "H"],
      "GO" => ["Goiás"               , "I"],
      "MA" => ["Maranhão"            , "J"],
      "MT" => ["Mato Grosso"         , "K"],
      "MS" => ["Mato Grosso do Sul"  , "L"],
      "MG" => ["Minas Gerais"        , "M"],
      "PA" => ["Pará"                , "N"],
      "PB" => ["Paraíba"             , "O"],
      "PR" => ["Paraná"              , "P"],
      "PE" => ["Pernambuco"          , "Q"],
      "PI" => ["Piauí"               , "R"],
      "RJ" => ["Rio de Janeiro"      , "S"],
      "RN" => ["Rio Grande do Norte" , "T"],
      "RS" => ["Rio Grande do Sul"   , "U"],
      "RO" => ["Rondônia"            , "V"],
      "RR" => ["Roraima"             , "W"],
      "SC" => ["Santa Catarina"      , "X"],
      "SP" => ["São Paulo"           , "Y"],
      "SE" => ["Sergipe"             , "Z"],
      "TO" => ["Tocantins"           , "a"]}
  end
  def nav_links
    [
      { name: 'Ranking',       url: '#ranking' },
      { name: 'Por Tempo',     url: '#por-tempo' },
      { name: 'Top 10',        url: '#top-10' },
      { name: 'Atendimentos',  url: '#atendimentos' },
      { name: 'Por Estado',    url: '#por-estado' },
      { name: 'Estatísticas',  url: '#estatisticas' },
      { name: 'Redes Sociais', url: '#redes-sociais' },
      { name: 'Comentários',   url: '#comentarios' }
    ]
  end

end
