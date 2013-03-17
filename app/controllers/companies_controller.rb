#encoding: utf-8
class CompaniesController < ApplicationController

  def index
    @companies = [
      { name: 'OI / Brasil Telecom',         count: 15780  },
      { name: 'Ponto Frio / Casas Bahia',         count: 15557  },
      { name: 'Itaú / Unibanco',      count: 11079 },
      { name: 'LG',   count: 9336 },
      { name: 'Claro',    count: 9276  },
      { name: 'Ricardo Eletro',        count: 7975 },
      { name: 'Samsung', count: 7571 },
      { name: 'Sony Ericsson',       count: 6082  },
      { name: 'Bradesco',        count: 6758 },
      { name: 'Nokia', count: 6074 },
      { name: 'Tim',       count: 5959  },
      { name: 'Vivo',  count: 5761 },
      { name: 'Americanas.com / Submarino / Shoptime', count: 5655 },
      { name: 'Banco do Brail',    count: 3701 },
      { name: 'Consul / Brastemp',      count: 2874 },
      { name: 'Citibank',       count: 2735 },
      { name: 'Wallmart',  count: 2640   },
      { name: 'Banco BMG',      count: 2637  },
      { name: 'Banco Santander / Real',         count: 2606 },
      { name: 'Mabe / GE / Dako',    count: 2544 },
      { name: 'Carrefour',      count: 2530  }
    ].sort_by {|company| company[:count] * -1 }
    @nav_links = nav_links
  end

  def show
    #@company  = Company.where(strNomeFantasia: params[:nome].upcase).first

    @name = params[:nome]
    @complaints = Complaint.where(strNomeFantasia: params[:nome].upcase)
    @complaints_by_type = Hash[group(@complaints).sort.reverse]
    c = @complaints.first
    @company = {nome: c.strNomeFantasia, descricao: c.DescCNAEPrincipal}
    @regions  = regions
    @states   = @complaints.group_by {|comp| comp.UF}

    @nav_links = nav_links
  end

  def search
    companies = Complaint.group_by_company(params[:nome])
                         .sort { |a, b| b["value"]["count"] <=> a["value"]["count"] }
    @companies = companies[0, 20].map do |company|
      { name: company["_id"], count: company["value"]["count"].to_i }
    end
    render :index
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
