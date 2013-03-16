#encoding: utf-8
class CompaniesController < ApplicationController

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

  def proto
    @complaints = [
      {
        count: '6404',
        name: "Telefone (Convencional, Celular, Interfone, Etc.)"
      },{
        count: '1243',
        name: "Televisão / Vídeo Cassete / Filmadora / Video-Laser"
      },{
        count: '709',
        name: "Telefonia Celular"
      },{
        count: '329',
        name: "Microcomputador / Produtos de Informática"
      },{
        count: '200',
        name: "Aparelho de Som ( Gravador, 3x1, CD )"
      },{
        count: '126',
        name: "Aparelho DVD"
      },{
        count: '113',
        name: "Energia Elétrica"
      },{
        count: '91',
        name: "Eletroeletrônico Importado"
      },{
        count: '76',
        name: "Aquecedor / Ventilador / Ar Condicionado / Circulador de Ar"
      },{
        count: '64',
        name: "Máquina de Lavar Roupa / Louça e Secadora"
      }
    ]
    @states = regions
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
