class CompaniesController < ApplicationController
  def show
    @company = Company.where(strNomeFantasia: params[:nome].upcase).first
    @complaints_by_type = Hash[group(@company.complaints).sort.reverse]
  end

  def group(complaints)
    #MAP REDUCE MTF! DO YOU USE IT?
    #SAY WHATTTTT??
    complaints.group_by {|compl| compl.CodigoProblema }
  end
end