export interface ProductMaterial {
  rawMaterialId: number;
  code: string;
  name: string;
  quantity: number;
}

export interface Product {
  id?: number;
  code: string;
  name: string;
  price: number;
  materials: ProductMaterial[];
}
