class Complaint
  include Mongoid::Document

  #TODO: Temporário. Apenas para extrair a lista de empresas
  field :strRazaoSocial, type: String
  field :strNomeFantasia, type: String
  field :UF, type: String

  index({ strRazaoSocial: 1 }, { unique: false, name: "strRazaoSocial_index" })
  index({ strNomeFantasia: 1 }, { unique: false, name: "strNomeFantasia_index" })
  index({ UF: 1 }, { unique: false, name: "UF_index" })
  index({ slug: 1 }, { unique: false, name: "slug_index" })

  belongs_to :company

  def to_param
    slug
  end

  def atendida?
    self.Atendida == 'true'
  end

  def self.group_by_company(search_params)
    map = %Q{
      function() {
        emit(this.slug, {name: this.strNomeFantasia, slug: this.slug, count: 1})
      }
    }

    reduce = %Q{
      function(key, values) {
        var count = 0;
        values.forEach(function (v) {
          count += v.count;
        });
        return {name: values[0].name, slug: values[0].slug, count: count};
      }
    }

    query = if search_params
              self.any_of(search_params)
            else
              self
            end
    query.map_reduce(map, reduce).out(inline: true)
  end

  def self.group_by_fulfillment_month_year(search_params)
    map = %Q{
      function() {
        var month_year = this.DataAbertura.slice(0, 7);
        var fulfilled = 0;

        if (this.Atendida === "true") {
          fulfilled = 1;
        }

        emit(month_year, {fulfilled: fulfilled, count: 1})
      }
    }

    reduce = %Q{
      function(key, values) {
        var count = 0;
        var fulfilled = 0;

        values.forEach(function (v) {
          count += v.count;
          fulfilled += v.fulfilled;
        });

        return {fulfilled: fulfilled, count: count};
      }
    }

    self.any_of(search_params).map_reduce(map, reduce).out(inline: true)
  end

  def self.generate_slugs!
    Complaint.any_of(slug: nil).each do |complaint|
      complaint.update_attributes!(slug: complaint.strNomeFantasia.to_url)
    end
  end

  def self.fix_nome_fantasia!
    Complaint.any_of(strNomeFantasia: 'NULL').each do |complaint|
      complaint.update_attributes!(strNomeFantasia: complaint.strRazaoSocial,
                                   slug: complaint.strRazaoSocial.slug)
    end
  end
end
