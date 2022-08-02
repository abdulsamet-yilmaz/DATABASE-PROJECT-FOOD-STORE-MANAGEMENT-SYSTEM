Create Trigger Trg_UpdateTotalColumnsOfSale
  on Sale 
  after insert
As
Begin
  Declare @Barcode bigint
  Set @Barcode = (Select i.Barcode From inserted i)

  Declare @TaxRate decimal(4,2)
  Set @TaxRate = ((Select TaxPercentage From Product Where Barcode = @Barcode) / 100.0)

  Declare @Quantity decimal(9,3)
  Set @Quantity = (Select i.Quantity From inserted i)

  Declare @Price decimal(9,2)
  Set @Price = (Select Top (1) pph.Price
                From ProductPriceHistory pph
                Where pph.Barcode = @Barcode
                Order By pph.EffectiveDate desc)

--Update Totalprice and TotalTaxCost of this sale
  Update s
  Set s.TotalPrice = (@Quantity * @Price), s.TotalTaxCost = ((@Price * @TaxRate) * @Quantity) 
  From Sale s
  Where s.SaleNo = (select i.SaleNo From inserted i)

--Update StockAmount of saled Prodcut
  Update p
  Set p.StockAmount = (p.StockAmount - @Quantity)
  From Product p
  Where p.Barcode = @Barcode

End