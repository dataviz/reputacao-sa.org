#encoding: utf-8
class CompaniesController < ApplicationController

  def index
    @nav_links = nav_links
  end

  def show
    @name = unslugfy(params[:name]).upcase
    @complaints = Complaint.where(strNomeFantasia: @name)
    @complaints_by_type = Hash[group(@complaints).sort.reverse]
    c = @complaints.first
    @company = {name: c.strNomeFantasia, descricao: c.DescCNAEPrincipal}
    @regions  = regions
    @states   = @complaints.group_by {|comp| comp.UF}
    @solved = @complaints.select{|c| c.atendida? }
    @unsolved = @complaints.reject{|c| c.atendida? }
    @unsolved_by_type = Hash[group(@unsolved).sort.reverse]
    @solved_by_type = Hash[group(@solved).sort.reverse]
    @nav_links = nav_links
  end

  def search
    companies = Complaint.group_by_company(params[:name])
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
