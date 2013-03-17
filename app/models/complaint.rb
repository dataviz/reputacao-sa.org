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

  def self.group_by_company(name)
    regexp = /.*#{Regexp.quote(name.upcase)}.*/
    map = %Q{
      function() {
        emit(this.strNomeFantasia, {count: 1})
      }
    }

    reduce = %Q{
      function(key, values) {
        return {count: values.length};
      }
    }

    self.any_of(strNomeFantasia: regexp).map_reduce(map, reduce).out(inline: true)
  end
end
