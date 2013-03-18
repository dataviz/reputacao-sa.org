#encoding: utf-8
class CompaniesController < ApplicationController
  def index
    @nav_links = nav_links
    @companies = top_companies

    render :stream => true
  end

  def show
    @companies = top_companies
    @complaints = Complaint.where(slug: params[:slug])
    @name = @complaints[0].strNomeFantasia
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

    number_of_slices = 5
    max_complaints_count_state = @states.max_by { |state| state.last.length }
    @max_complaints_count = @states[max_complaints_count_state[0]].length
    @slice = (@max_complaints_count/number_of_slices.to_f).ceil

    @complaints_by_fulfillment = complaints_by_fulfillment(params[:slug])

    render :stream => true
  end

  def search
    regexp = /.*#{Regexp.quote(params[:name].upcase)}.*/
    search_params = { strNomeFantasia: regexp }
    @companies = top_companies(search_params)

    render :index, :stream => true
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
      { name: 'Informações gerais',
        url: '#informacoes-gerais' },
      { name: 'Estatísticas gerais',
        url: '#estatisticas-gerais' },
      { name: 'Ocorrências por mês',
        url: '#ocorrencias-por-mes' },
      { name: 'Solucionados × não solucionados',
        url: '#solucionados-nao-solucionados' },
      { name: 'Reclamações mais frequentes',
        url: '#reclamacoes-mais-frequentes' },
      { name: 'Não solucionados mais frequentes',
        url: '#nao-solucionados-mais-frequentes' },
      { name: 'Solucionados mais frequentes',
        url: '#solucionados-mais-frequentes' },
      { name: 'Reclamações por estados',
        url: '#por-estados' },
      { name: 'Compartilhar',
        url: '#compartilhar' }
    ]
  end

  private
  def complaints_by_fulfillment(slug)
    results = {}
    complaints = Complaint.group_by_fulfillment_month_year(slug: slug)
    complaints.each do |complaint|
      year, month = complaint['_id'].split('-')
      results[month.to_i] ||= {}
      results[month.to_i][year] = complaint['value']
    end
    results
  end

  def top_companies(search_params=nil)
    return top_20 if search_params.nil?

    Complaint.group_by_company(search_params).map do |complaint|
      { name: complaint['_id'], slug: complaint['value']['slug'], count: complaint['value']['count'].to_i }
    end.sort_by {|company| company[:count] * -1 }[0, 20]
  end

  def top_20
    [{:name=>"CLARO", :slug=>"claro", :count=>1052},
     {:name=>"OI", :slug=>"oi", :count=>843},
     {:name=>"PONTO FRIO", :slug=>"ponto-frio", :count=>785},
     {:name=>"AMERICANAS.COM/SUBMARINO/SHOPTIME", :slug=>"americanas-dot-com-slash-submarino-slash-shoptime", :count=>731},
     {:name=>"RICARDO ELETRO", :slug=>"ricardo-eletro", :count=>709},
     {:name=>"LG ELETRONICS", :slug=>"lg-eletronics", :count=>688},
     {:name=>"TIM CELULAR", :slug=>"tim-celular", :count=>644},
     {:name=>"LG", :slug=>"lg", :count=>591},
     {:name=>"SAMSUNG", :slug=>"samsung", :count=>544},
     {:name=>"VIVO", :slug=>"vivo", :count=>463},
     {:name=>"SAMSUNG ELETRONICA DA AMAZONIA LTDA", :slug=>"samsung-eletronica-da-amazonia-ltda", :count=>439},
     {:name=>"LOJAS INSINUANTE", :slug=>"lojas-insinuante", :count=>427},
     {:name=>"CASAS BAHIA", :slug=>"casas-bahia", :count=>404},
     {:name=>"TELEFONICA", :slug=>"telefonica", :count=>386},
     {:name=>"ELETROPAULO METROPOLITANA", :slug=>"eletropaulo-metropolitana", :count=>375},
     {:name=>"BANCO PANAMERICANO S/A", :slug=>"banco-panamericano-s-slash-a", :count=>358},
     {:name=>"NOKIA", :slug=>"nokia", :count=>350},
     {:name=>"OI CELULAR/OI MÓVEL", :slug=>"oi-celular-slash-oi-m-vel", :count=>342},
     {:name=>"COELBA", :slug=>"coelba", :count=>334},
     {:name=>"LG ELECTRONICS", :slug=>"lg-electronics", :count=>332}]
  end
end
