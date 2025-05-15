;; 1. Clasificar mayorista o menudista
(defrule clasificar-cliente
    (orden (customer-id ?cid) (part-number ?pn) (quantity ?q))
    =>
    (if (< ?q 10) then
        (printout t "Cliente " ?cid " es un *menudista* (cantidad de articulos comprados: " ?q ")." crlf)
    else
        (printout t "Cliente " ?cid " es un *mayorista* (cantidad de articulos comprados:  " ?q ")." crlf)))

;; 2. Promociones para incentivar al cliente a comprar mas
(defrule promociones-menudistas
    (orden (customer-id ?cid) (quantity ?q) (part-number ?pn))
    (test (< ?q 10))
    (accesorio (nombre ?nombre) (precio ?precio))
    =>
    (bind ?descuento (* ?precio 0.10))
    (bind ?precio-final (- ?precio ?descuento))
    (printout t "Cliente " ?cid ": por ser menudista, te recomendamos agregar el accesorio '" ?nombre"' con un 10% de descuento. Precio final: $" ?precio-final crlf))

;; 3. Recomendar mochila para quienes compren computadora
(defrule mochila-para-computadora
    (orden (order-number ?o) (part-number ?pn))
    (computadora (part-number ?pn))
    (accesorio (nombre kanken))
    =>
    (printout t "Recomendacion por comprar lap: agregar mochila a la orden " ?o "." crlf))

;; 4. Ofrecer membresia de plata a quienes compren mas de 20 articulos
(defrule customer-membership
    (cliente(customer-id ?id) (name ?cn))
    (orden(order-number ?order) (customer-id ?id) (quantity ?q))
    (test (> ?q 20))
    =>
    (printout t "cliente" ?id " es elegible para membresia de plata."))

;; 5. Hacer descuento adicional a clientes con membresia oro 
(defrule descuento-oro
    (orden (customer-id ?cid) (part-number ?pn))
    (cliente (customer-id ?cid) (membership oro))
    =>
    (printout t "Cliente " ?cid "con membresia oro: 5% de descuento adicional." crlf))

;; 6. Dar vales de rebaja en compra de airpods por comprar iphone
(defrule apple-vales
    (orden (customer-id ?cid) (part-number ?p1))
    (smartphone (part-number ?p1) (marca Apple) (modelo iphone16) (precio ?ps))
    =>
    (bind ?vales (* (div ?ps 1000) 100))
    (assert (vale (customer-id ?cid) (monto ?vales) (concepto combo-apple)))
    (printout t "Vale de $" ?vales " para airpods" crlf))

;; 7. Se ofrecen memorias a celulares con menos de 256 de almacenamiento
(defrule memorias
    (orden (customer-id ?cid) (part-number ?pn))
    (smartphone (part-number ?pn) (marca ?m) (modelo ?mod) (almacenamiento ?alm))
    (test (and (integerp ?alm) (< ?alm 256)))
    =>
    (printout t "Con el producto" ?pn "es recomendable llevar memorias de almacenamiento." crlf)
)

;; 7. Se ofrecen fundas si se compro un smartphone
(defrule funda-smartphone
    (orden (customer-id ?cid) (part-number ?pn))
    (smartphone (part-number ?pn) (modelo ?m) (marca ?mar) (precio ?p))
    (accesorio (nombre funda) (precio ?pf))
    =>
    (printout t "Lleva una funda con tu nuevo " ?mar " " ?m " por solo $" ?pf "." crlf))

;; 8. Sugerir membresia si el cliente no la tiene
(defrule sugerir-membresia
    (cliente (customer-id ?cid) (membership invitado))
    =>
    (printout t "Sugerencia: Cliente " ?cid " puede beneficiarse de una membresia, es inivtado." crlf))

;; 9. Descuento sugerido si tiene vale y hace compra
(defrule aplicar-vale-descuento
    (orden (customer-id ?cid))
    (vale (customer-id ?cid) (monto ?m))
    =>
    (printout t "Descuento disponible por vale acumulado para cliente " ?cid ": vale de $" ?m "." crlf))

;; 10. Promover smartphones Samsung si el cliente es de Mexico
(defrule samsung-para-mexico
    (cliente (customer-id ?cid) (country Mexico))
    (smartphone (marca Samsung))
    =>
    (printout t "Recomendacion para cliente " ?cid ": modelos Samsung disponibles." crlf))

;; 11. Sugerir cargador a quienes hagan pedidos internacionales
(defrule cargador-pedidos-internacionales
    (orden (order-number ?o) (delivery-type internacional))
    (accesorio (nombre cargadorc))
    =>
    (printout t "Recomendacion: incluir cargador compatible en orden internacional " ?o "." crlf))

;; 12. Dar promo por ser cliente invitado
(defrule bienvenida-invitado
    (cliente (customer-id ?cid) (membership invitado))
    =>
    (assert (vale (customer-id ?cid) (monto 150) (concepto bienvenida)))
    (printout t "Cliente " ?cid " invitado: promocion de bienvenida activada" crlf))

;;13. Sugerir mochilas para clientes que residen en peru
(defrule sugerir-kanken
    (cliente (country Peru))
    =>
    (printout t "Sugerir mochila Kanken para regreso a clases en Peru" crlf))

;;14. Sugerir accesorios para compu grande
(defrule accesorios-pc-grande
    (computadora (part-number ?pn) (tamaño grande))
    =>
    (printout t "Sugerir accesorios ergonomicos para computadora grande " ?pn crlf))

;;15 Cobro de aduana para envios internacionales desde China
(defrule aduana-china
    (cliente (customer-id ?cid) (country China))
    (orden (customer-id ?cid) (delivery-type internacional))
    =>
    (printout t "Aplicar cobro de aduana para envio internacional desde China" crlf))

;;16 Recomendar seguro de envio para compras internacionales > $10,000
(defrule seguro-envio
    (orden (customer-id ?cid) (part-number ?pn) (delivery-type internacional))
    (or (smartphone (part-number ?pn) (precio ?p))
        (computadora (part-number ?pn) (precio ?p)))
    (test (and (or (integerp ?p) (floatp ?p)) (> ?p 10000)))
    =>
    (printout t "Sugerencia: agregar seguro al envio internacional para cliente " ?cid crlf))

;;17 Promocion para clientes que usan tarjeta BBVA
(defrule promo-bbva
    (tarjeta (customer-id ?cid) (banco bbva))
    =>
    (assert (vale (customer-id ?cid) (monto 250) (concepto promo-bbva)))
    (printout t "Promocion especial BBVA aplicada a cliente " ?cid crlf))

;; 18. Alerta si cliente invitado hace compra internacional
(defrule alerta-invitado-internacional
    (cliente (customer-id ?cid) (membership invitado))
    (orden (customer-id ?cid) (delivery-type internacional))
    =>
    (printout t "Alerta: cliente invitado con orden internacional. Verificar." crlf))

;; 19. Recomendar compra adicional si el pedido es pequeño
(defrule sugerir-compra-adicional
    (orden (customer-id ?cid) (quantity ?q))
    (test (< ?q 2)) 
    =>
    (printout t "¿Te gustaría agregar otro producto y recibir envío gratis?" crlf))

;; 20. Recomendar mochila si el pedido incluye laptop
(defrule recomendar-mochila
    (orden (order-number ?o) (part-number ?pn))
    (computadora (part-number ?pn))
    =>
    (printout t "Sugerencia orden:" ?o "Deseas una mochila para transportar tu laptop?" crlf))
