#encoding: utf-8
class CompaniesController < ApplicationController
  def show
    @company = Company.where(strNomeFantasia: params[:nome].upcase).first
    @complaints_by_type = Hash[group(@company.complaints).sort.reverse]
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
    @states = [
      { count: (rand*666).to_i, acronym:"AC", name: "Acre"                 , letter: "A" },
      { count: (rand*666).to_i, acronym:"AL", name: "Alagoas"              , letter: "B" },
      { count: (rand*666).to_i, acronym:"AP", name: "Amapá"                , letter: "C" },
      { count: (rand*666).to_i, acronym:"AM", name: "Amazonas"             , letter: "D" },
      { count: (rand*666).to_i, acronym:"BA", name: "Bahia"                , letter: "E" },
      { count: (rand*666).to_i, acronym:"CE", name: "Ceará"                , letter: "F" },
      { count: (rand*666).to_i, acronym:"DF", name: "Distrito Federal"     , letter: "G" },
      { count: (rand*666).to_i, acronym:"ES", name: "Espírito Santo"       , letter: "H" },
      { count: (rand*666).to_i, acronym:"GO", name: "Goiás"                , letter: "I" },
      { count: (rand*666).to_i, acronym:"MA", name: "Maranhão"             , letter: "J" },
      { count: (rand*666).to_i, acronym:"MT", name: "Mato Grosso"          , letter: "K" },
      { count: (rand*666).to_i, acronym:"MS", name: "Mato Grosso do Sul"   , letter: "L" },
      { count: (rand*666).to_i, acronym:"MG", name: "Minas Gerais"         , letter: "M" },
      { count: (rand*666).to_i, acronym:"PA", name: "Pará"                 , letter: "N" },
      { count: (rand*666).to_i, acronym:"PB", name: "Paraíba"              , letter: "O" },
      { count: (rand*666).to_i, acronym:"PR", name: "Paraná"               , letter: "P" },
      { count: (rand*666).to_i, acronym:"PE", name: "Pernambuco"           , letter: "Q" },
      { count: (rand*666).to_i, acronym:"PI", name: "Piauí"                , letter: "R" },
      { count: (rand*666).to_i, acronym:"RJ", name: "Rio de Janeiro"       , letter: "S" },
      { count: (rand*666).to_i, acronym:"RN", name: "Rio Grande do Norte"  , letter: "T" },
      { count: (rand*666).to_i, acronym:"RS", name: "Rio Grande do Sul"    , letter: "U" },
      { count: (rand*666).to_i, acronym:"RO", name: "Rondônia"             , letter: "V" },
      { count: (rand*666).to_i, acronym:"RR", name: "Roraima"              , letter: "W" },
      { count: (rand*666).to_i, acronym:"SC", name: "Santa Catarina"       , letter: "X" },
      { count: (rand*666).to_i, acronym:"SP", name: "São Paulo"            , letter: "Y" },
      { count: (rand*666).to_i, acronym:"SE", name: "Sergipe"              , letter: "Z" },
      { count: (rand*666).to_i, acronym:"TO", name: "Tocantins"            , letter: "a" }
    ].sort_by { |state| state[:count] }
  end

end
