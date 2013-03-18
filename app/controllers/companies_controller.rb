#encoding: utf-8
class CompaniesController < ApplicationController

  caches_page :index, :show

  def index
    @nav_links = nav_links
    @companies = top_companies
  end

  def show
    @companies = top_companies
    @complaints = Complaint.where(slug: params[:slug])
    @name = @complaints[0].strNomeFantasia
    @complaints_by_type = Hash[group(@complaints)]
    c = @complaints.first
    @company = {name: c.strNomeFantasia, descricao: c.DescCNAEPrincipal}
    @regions  = regions
    @states   = @complaints.group_by {|comp| comp.UF}
    @solved = @complaints.select{|c| c.atendida? }
    @unsolved = @complaints.reject{|c| c.atendida? }
    @unsolved_by_type = Hash[group(@unsolved)]
    @solved_by_type = Hash[group(@solved)]
    @nav_links = nav_links

    @number_of_slices = 10
    max_complaints_count_state = @states.max_by { |state| state.last.length }
    @max_complaints_count = @states[max_complaints_count_state[0]].length

    @complaints_by_month_year = complaints_by_month_year(params[:slug])

    @complaints_histogram = complaints_histogram(params[:slug])
    @from = @complaints_histogram.first[0..1]
    @to = @complaints_histogram.last[0..1]
  end

  def search
    regexp = /.*#{Regexp.quote(params[:name].upcase)}.*/
    search_params = { strNomeFantasia: regexp }
    @companies = top_companies(search_params)

    render :index
  end

  def group(complaints)
    # MAP REDUCE MTF! DO YOU USE IT?
    # SAY WHATTTTT??
    # SAY WHAT ONE MORE TIME. I DARE YOU.
    # I DOUBLE DARE YOU!
    complaints.group_by {|compl| compl.CodigoProblema }.sort_by { |k, v| v.length * -1 }
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
      { name: 'Histórico detalhado',
        url: '#historico-detalhado' },
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
  def complaints_by_month_year(slug)
    results = {}
    complaints_by_fulfillment(slug).each do |complaint|
      year, month = complaint['_id'].split('-')
      results[month.to_i] ||= {}
      results[month.to_i][year] = complaint['value']
    end
    results
  end

  def complaints_histogram(slug)
    results = []
    complaints_by_fulfillment(slug).each do |complaint|
      year, month = complaint['_id'].split('-').map(&:to_i)
      results << [year, month, complaint['value']['count'].to_i]
    end
    results.sort
  end

  def complaints_by_fulfillment(slug)
    @_complaints_cache ||= Complaint.group_by_fulfillment_month_year(slug: slug)
  end

  def top_companies(search_params=nil)
    return top_20 if search_params.nil?

    Complaint.group_by_company(search_params).map do |complaint|
      value = complaint['value']
      { name: value['name'], slug: value['slug'], count: value['count'].to_i }
    end.sort_by {|company| company[:count] * -1 }[0, 20]
  end

  def top_20
    [{:name=>"CLARO", :slug=>"claro", :count=>7437},
     {:name=>"OI", :slug=>"oi", :count=>6200},
     {:name=>"SONY ERICSSON", :slug=>"sony-ericsson", :count=>4460},
     {:name=>"LG", :slug=>"lg", :count=>4362},
     {:name=>"VIVO", :slug=>"vivo", :count=>4214},
     {:name=>"RICARDO ELETRO", :slug=>"ricardo-eletro", :count=>4108},
     {:name=>"SAMSUNG", :slug=>"samsung", :count=>4076},
     {:name=>"NOKIA", :slug=>"nokia", :count=>3966},
     {:name=>"PONTO FRIO", :slug=>"ponto-frio", :count=>3414},
     {:name=>"TIM", :slug=>"tim", :count=>2430},
     {:name=>"LOJAS INSINUANTE", :slug=>"lojas-insinuante", :count=>2261},
     {:name=>"TIM CELULAR", :slug=>"tim-celular", :count=>2227},
     {:name=>"CASAS BAHIA", :slug=>"casas-bahia", :count=>2177},
     {:name=>"LG ELETRONICS", :slug=>"lg-eletronics", :count=>2139},
     {:name=>"OI FIXO", :slug=>"oi-fixo", :count=>2003},
     {:name=>"AMERICANAS.COM/SUBMARINO/SHOPTIME", :slug=>"americanas-dot-com-slash-submarino-slash-shoptime", :count=>1929},
     {:name=>"EMBRATEL", :slug=>"embratel", :count=>1896},
     {:name=>"TELEMAR (OI FIXO E MÓVEL, OI PAGGO, VELOX, OI NET)", :slug=>"telemar-oi-fixo-e-m-vel-oi-paggo-velox-oi-net", :count=>1890},
     {:name=>"SAMSUNG ELETRONICA DA AMAZONIA LTDA", :slug=>"samsung-eletronica-da-amazonia-ltda", :count=>1879},
     {:name=>"OI MÓVEL", :slug=>"oi-m-vel", :count=>1857}]
  end
end
