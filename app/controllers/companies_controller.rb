#encoding: utf-8
class CompaniesController < ApplicationController
  def show
    @company = Company.where(strNomeFantasia: params[:nome].upcase).first
    @complaints_by_type = Hash[group(@company.complaints).sort.reverse]
    @regions = regions
    @states = @company.complaints_by_region
  end

  def group(complaints)
    # MAP REDUCE MTF! DO YOU USE IT?
    # SAY WHATTTTT??
    # SAY WHAT ONE MORE TIME. I DARE YOU.
    # I DOUBLE DARE YOU!
    complaints.group_by {|compl| compl.CodigoProblema }
  end

  def proto
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

end
