 (deffacts smartphones
(smartphone (part-number 100) (marca Samsung) (precio 12000) (modelo A31) (color blanco) (almacenamiento 256) (stock 10))
(smartphone (part-number 101) (marca Apple) (precio 16000) (modelo iphone16) (color negro) (almacenamiento 512) (stock 15))
(smartphone (part-number 102) (marca Xiaomi) (precio 8000) (modelo 12pro) (color rojo) (almacenamiento 128) (stock 20)))

(deffacts computadoras
(computadora (part-number 200) (marca huawei) (precio 17000) (modelo D14) (color gris) (tamaño mediano) (stock 15))
(computadora (part-number 201) (marca apple) (precio 40000) (modelo macpro) (color blanco) (tamaño grande) (stock 20))
(computadora (part-number 202) (marca hp) (precio 5000) (modelo hp14) (color negro) (tamaño mediano) (stock 25)))

(deffacts accesorios
(accesorio (part-number 300) (categoria decoracion) (nombre funda) (precio 120) (stock 100))
(accesorio (part-number 301) (categoria musica) (nombre airpods) (precio 1200) (stock 150))
(accesorio (part-number 302) (categoria mochilas) (nombre kanken) (precio 1300) (stock 200))
(accesorio (part-number 303) (categoria almacenamiento) (nombre memoriasd) (precio 300) (stock 150))
(accesorio (part-number 304) (categoria adaptadores) (nombre cargadorc) (precio 100) (stock 300)))

(deffacts clientes
   (cliente (customer-id 1) (name Bowie) (country Londres) (address patria 25) (membership oro))
   (cliente (customer-id 2) (name Trent) (country Estados Unidos) (address balcon 345) (membership plata))
   (cliente (customer-id 3) (name Maynard) (country Peru) (address arcoiris 505) (membership bronce))
   (cliente (customer-id 4) (name Kim) (country Mexico) (address chihuahua 997) (membership invitado))
   (cliente (customer-id 5) (name Dany) (country Italia) (address blanco 654) (membership invitado))
   (cliente (customer-id 6) (name Robert) (country China) (address muralla 771) (membership plata)))

(deffacts ordenes
   (orden (order-number 1) (customer-id 1) (part-number 200) (quantity 10) (delivery-type local) (payment-type contado))
   (orden (order-number 11) (customer-id 2) (part-number 201) (quantity 5) (delivery-type internacional) (payment-type tarjeta))
   (orden (order-number 111) (customer-id 3) (part-number 202) (quantity 15) (delivery-type local) (payment-type contado))
   (orden (order-number 1111) (customer-id 4) (part-number 100) (delivery-type internacional) (payment-type contado))
   (orden (order-number 11111) (customer-id 5) (part-number 101) (quantity 100) (delivery-type internacional) (payment-type tarjeta))
   (orden (order-number 111111) (customer-id 6) (part-number 102) (quantity 10) (delivery-type local) (payment-type tarjeta)))

(deffacts tarjetas-aceptadas
   (tarjeta (customer-id 2) (banco bbva) (grupo premium) (exp-date 11/12/22))
   (tarjeta (customer-id 5) (banco santander) (grupo platinum) (exp-date 2/4/27))
   (tarjeta (customer-id 6) (banco bbva) (grupo basico) (exp-date 3/6/28)))

(deffacts vales
   (vale (customer-id 4) (monto 400) (concepto descuentos)))
