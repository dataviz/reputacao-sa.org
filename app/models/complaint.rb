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

  def self.group_by_fulfillment_month_year(name)
    regexp = /.*#{Regexp.quote(name.upcase)}.*/
    map = %Q{
      function() {
        var month_year = this.DataArquivamento.slice(0, 7);
        var fulfilled = 0;

        if (this.Atendida === "true") {
          fulfilled = 1;
        }

        emit(month_year, {fulfilled: fulfilled, count: 1})
      }
    }

    reduce = %Q{
      function(key, values) {
        var fulfilled = 0;

        for (var i in values) {
          if (values[i].fulfilled == 1) {
            fulfilled += 1;
          }
        }

        return {fulfilled: fulfilled, count: values.length};
      }
    }

    self.any_of(strNomeFantasia: regexp).map_reduce(map, reduce).out(inline: true)
  end
end
