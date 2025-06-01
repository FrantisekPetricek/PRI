from random import randint
"INSERT INTO `mistnosti` (`id`, `kod`, `id_bud`, `id_typ`, `podlazi`) VALUES (NULL, '', '3', '1', '0');"

def generujNahodnyMistnosti(pocet:int):
    for mistnost in range(pocet):
        id_bud = randint(3,5)
        id_typ = randint(1,8)
        podlazi = randint(-1,3)

        print(f"INSERT INTO `mistnosti` (`id`, `kod`, `id_bud`, `id_typ`, `podlazi`) VALUES (NULL, '', '{id_bud}', '{id_typ}', '{podlazi}');")


generujNahodnyMistnosti(10)