periodicity_mensal = Periodicity.create(name: 'Mensal', period: 1)
periodicity_trimestral = Periodicity.create(name: 'Trimestral', period: 3)
periodicity_semestral = Periodicity.create(name: 'Semestral', period: 6)
periodicity_anual = Periodicity.create(name: 'Anual', period: 12)
periodicity_trienal = Periodicity.create(name: 'Trienal', period: 36)

hospedagem = ProductType.create(name: 'Hospedagem', 
                                description: 'É um espaço em servidor para que você '\
                                             'possa armazenar o seu site')