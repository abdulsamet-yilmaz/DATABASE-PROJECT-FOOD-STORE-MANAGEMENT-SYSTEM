Create Trigger Trg_UpdateTotalColumnsOfCustReturn
  on CustomerReturn
  after insert
As
Begin
  Declare @Quantity decimal(9,3)
  Set @Quantity = (Select i.Quantity From inserted i)

  Declare @TaxRate decimal(4,2)
  Set @TaxRate = ((Select p.TaxPercentage From Product p, inserted i Where p.Barcode = i.Barcode) / 100.0)

--Update TotalPrice and TotalTax for this return
  Update cr
  Set cr.TotalPrice = (cr.UnitReturnPrice * cr.Quantity), cr.TotalTax = ((cr.UnitReturnPrice * @TaxRate) * @Quantity)
  From CustomerReturn cr
  Where cr.ReturnNo = (Select i.ReturnNo From inserted i)

--Update StockAmount for returned product
  Update p
  Set p.StockAmount = (p.StockAmount + @Quantity)
  From Product p
  Where p.Barcode = (Select i.Barcode From inserted i)
End