class Company
  include Mongoid::Document
  [:strRazaoSocial, :strNomeFantasia, :NumeroCNPJ, :radicalCNPJ, :RazaoSocialRFB, :NomeFantasiaRFB,
   :CNAEPrincipal, :DescCNAEPrincipal].each {|at| field at}

  validates_uniqueness_of :NumeroCNPJ
  validates_presence_of :strNomeFantasia
  has_many :complaints

end