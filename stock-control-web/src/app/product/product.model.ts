export interface ProductMaterial {
  rawMaterialId: number;
  quantity: number;
}

export interface Product {
  id?: number;
  code: string;
  name: string;
  price: number;
  materials: ProductMaterial[];
}
