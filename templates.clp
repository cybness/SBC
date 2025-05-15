(deftemplate smartphone
    (slot part-number)
    (slot marca)
    (slot modelo)
    (slot precio)
    (slot color)
    (slot almacenamiento)
    (slot stock (type INTEGER)))

(deftemplate computadora
    (slot part-number)
    (slot marca)
    (slot modelo)
    (slot precio)
    (slot color)
    (slot tamaño)
    (slot stock))

(deftemplate accesorio
    (slot part-number)
    (slot categoria)
    (slot nombre)
    (slot marca)
    (slot precio)
    (slot stock))

(deftemplate cliente
    (slot customer-id)
    (multislot name)
    (multislot country)
    (multislot address)
    (slot membership))

(deftemplate orden
    (slot order-number)
    (slot customer-id)
    (slot part-number)
    (slot quantity (default 1))
    (slot delivery-type)
    (slot payment-type))

(deftemplate tarjeta
    (slot customer-id)
    (slot banco)
    (slot grupo)
    (slot exp-date))

(deftemplate vale
    (slot customer-id)
    (slot monto)
    (slot concepto))
