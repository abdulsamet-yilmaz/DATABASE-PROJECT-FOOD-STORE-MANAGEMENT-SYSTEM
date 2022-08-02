Create Trigger Trg_UpdTotalClmnOfReturnToComp
  on ReturnToCompany
  after insert
As
Begin
  Declare @Quantity decimal(9,3)
  Set @Quantity = (Select i.Quantity From inserted i)

--Update TotalPrice of recent return to company
  Update rtc
  Set rtc.TotalPrice = (rtc.UnitReturnPrice * rtc.Quantity)
  From ReturnToCompany rtc
  Where rtc.ReturnNo = (Select i.ReturnNo From inserted i)

--Update StockAmount of returned product
  Update p
  Set p.StockAmount = (p.StockAmount - @Quantity)
  From Product p
  Where p.Barcode = (Select i.Barcode From inserted i)
End