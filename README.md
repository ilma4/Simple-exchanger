# Simple-exchanger

1. Upload both `.sol` files to Remix IDE
2. Compile them
3. Create token
4. Create exchanger for that token
5. Use exchanger


## Exchanger features (everybody)
- Sell tokens (`sell`)
- Buy tokens (`purchase`)

## Exchanger features (only owner)
- Send wei to the exchanger (`fillWei`)
- Reseive wei from exchanger (`sendWeiToOwner`)
- Change exchangeRate
- Destroy exchanger. Destroyed exchanger returns all wei to the owner and no longer perform any other operations.

## Important

