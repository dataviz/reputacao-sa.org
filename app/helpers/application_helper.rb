#encoding: utf-8
module ApplicationHelper

  def slugfy(name)
    name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def top_companies
    [
      { position: 1, name: 'OI / Brasil Telecom',         count: 15780  },
      { position: 2, name: 'Ponto Frio / Casas Bahia',         count: 15557  },
      { position: 3, name: 'Itaú / Unibanco',      count: 11079 },
      { position: 4, name: 'LG',   count: 9336 },
      { position: 5, name: 'Claro',    count: 9276  },
      { position: 6, name: 'Ricardo Eletro',        count: 7975 },
      { position: 7, name: 'Samsung', count: 7571 },
      { position: 8, name: 'Sony Ericsson',       count: 6082  },
      { position: 9, name: 'Bradesco',        count: 6758 },
      { position: 10, name: 'Nokia', count: 6074 },
      { position: 11, name: 'Tim',       count: 5959  },
      { position: 12, name: 'Vivo',  count: 5761 },
      { position: 13 , name: 'Americanas.com / Submarino / Shoptime', count: 5655 },
      { position: 14 , name: 'Banco do Brail',    count: 3701 },
      { position: 15 , name: 'Consul / Brastemp',      count: 2874 },
      { position: 16 , name: 'Citibank',       count: 2735 },
      { position: 17 , name: 'Wallmart',  count: 2640   },
      { position: 18 , name: 'Banco BMG',      count: 2637  },
      { position: 19 , name: 'Banco Santander / Real',         count: 2606 },
      { position: 20 , name: 'Mabe / GE / Dako',    count: 2544 },
      { position: 21 , name: 'Carrefour',      count: 2530  }
    ].sort_by {|company| company[:count] * -1 }
  end

end
