export interface ProductSuggestion {
  productName: string;
  productCode: string;
  quantityToProduce: number;
  unitPrice: number;
  subtotal: number;
}

export interface ProductionSuggestionResponse {
  suggestions: ProductSuggestion[];
  totalEstimatedValue: number;
}
