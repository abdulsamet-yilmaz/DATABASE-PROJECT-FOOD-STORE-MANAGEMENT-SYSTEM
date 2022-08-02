Create Trigger Trg_UpdateTotalColumnOfPurchase
  on Purchase
  after insert
As
Begin
  Declare @Quantity decimal(9,3)
  Set @Quantity = (Select i.Quantity From inserted i)

--Update TotalPrice for this purchase
  Update p
  Set p.TotalPrice = (p.UnitPurchasePrice * p.Quantity)
  From Purchase p
  Where p.PurchaseNo = (Select i.PurchaseNo From inserted i)

--Update StockAmount for purchased product
  Update p
  Set p.StockAmount = (p.StockAmount + @Quantity)
  From Product p
  Where p.Barcode = (Select i.Barcode From inserted i)
End