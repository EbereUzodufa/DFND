select UnitPrice price, sum(Quantity) qty
from InvoiceLine
group by 1
order by 1 desc