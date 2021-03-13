user = User.create!(email: 'luan.mesquita@hotmail.com', password: '123456')

mensal = Periodicity.create(name: 'Mensal', period: 1)
trimestral = Periodicity.create(name: 'Trimestral', period: 3)
semestral = Periodicity.create(name: 'Semestral', period: 6)
anual = Periodicity.create(name: 'Anual', period: 12)
trienal = Periodicity.create(name: 'Trienal', period: 36)

hospedagem = ProductType.create!(name: 'Hospedagem de Sites', 
                                description: 'É um espaço em servidor para que você '\
                                             'possa armazenar o seu site.')
email = ProductType.create!(name: 'Email', 
                           description: 'É um serviço de correio eletrônico '\
                                        'para envios e recebimentos de mensagens.')

cloud = ProductType.create!(name: 'Cloud Computing', 
                           description: 'É uma tecnologia que oferece recursos '\
                                        'computacionais remotos, como memória, '\
                                        'processamento e armazenamento de dados.')

go = Plan.create!(name: 'Go', description: '1 site, 3 emails (10GB cada), 1 ano de '\
                                           'de domínio grátis.',
                  product_type: hospedagem, details: 'PHP 5.2, 5.3, 5.4, 5.5, 5.6 e 7 '\
                                                     'ASP, ASP.NET 2.0/3.0/3.5/ e 4.0/4.'\
                                                     '5/4.5.1/4.5.2 (medium trust).',
                  status: 'activated')

initial = Plan.create!(name: 'Initial', description: '25 caixas postais, 15 GB por caixa '\
                                                     'A partir de R$ 1,05 por caixa.',
                       product_type: email, details: 'Antispam e antivírus, Aplicativo Type'\
                                                     ' App, Painel de controle, Versão mobile.',
                      status: 'activated')

cloud_server_pro = Plan.create!(name: 'Pro 1 GB', description: '1 GB de memória, 2 vCPUs, '\
                                                                     '20 GB de disco SSD '\
                                                                     '1 TB de transferência.',
                                product_type: cloud, details: 'Disco SSD, Escalabilidade vertical '\
                                                              'Acesso Root/Admin, Serviços adicionais.',
                                status: 'disabled')

price_one = Price.create!(plan_price: 315.60, plan: initial, periodicity: anual)
price_two = Price.create!(plan_price: 86.10, plan: initial, periodicity: trimestral)
price_three = Price.create!(plan_price: 29.60, plan: initial, periodicity: mensal)
price_four = Price.create!(plan_price: 74.70, plan: go, periodicity: trimestral)
price_five = Price.create!(plan_price: 298.80, plan: go, periodicity: anual)
price_six = Price.create!(plan_price: 79.00, plan: cloud_server_pro, periodicity: mensal)


