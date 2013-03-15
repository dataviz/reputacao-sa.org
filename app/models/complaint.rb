class Complaint
  include Mongoid::Document

  #TODO: Temporário. Apenas para extrair a lista de empresas
  field :strRazaoSocial, type: String
  field :strNomeFantasia, type: String
  field :UF, type: String

  index({ strRazaoSocial: 1 }, { unique: false, name: "strRazaoSocial_index" })
  index({ strNomeFantasia: 1 }, { unique: false, name: "strNomeFantasia_index" })
  index({ :UF => 1 }, { unique: false, name: "UF_index" })

  belongs_to :company

  def atendida?
    self.Atendida == 'true'
  end
end