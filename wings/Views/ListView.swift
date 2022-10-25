//
//  ListView.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

struct ListView: View {
    let listData: [ProductResponse]
    
    @State var coData: [CheckoutRequest] = []
    @State private var showShmrr: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            //Header
            HStack {
                Text("List Produk .... ")
                    .font(.custom(Cnst.txt.fInterBold, size: 16))
                    .foregroundColor(.N100)
                Spacer()
                
                NavigationLink {
                    CheckOutView(nampanData: coData)
                } label: {
                    VStack(alignment: .trailing, spacing: -8) {
                        let nmpn = coData.count > 0
                        if nmpn {
                            ZStack {
                                Circle()
                                    .foregroundColor(.G100)
                                    .frame(width: 18, height: 18)
                                Text("\(coData.count)")
                                    .font(.custom(Cnst.txt.fInterBold, size: 12))
                                    .foregroundColor(.N0)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.N0, lineWidth: 2)
                            )
                            .zIndex(1)
                        }
                        Image(systemName: "folder.fill")
                            .resizable()
                            .font(.custom(Cnst.txt.fInterBold, size: 16))
                            .foregroundColor(nmpn ? .G100: .N100)
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .padding()
            Divider()
            
            ScrollView(showsIndicators: false) {
                ForEach(listData) { product in
                    ItemCardView(product)
                }
            }
            .redacted(reason: showShmrr ? .placeholder: [])
        }
        .navigationBarHidden(true)
        .onAppear {
            showShmrr = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.showShmrr = false
            }
        }
    }
    
    
    func ItemCardView(_ prod: ProductResponse) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(prod.productCode)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(prod.productName.capitalized)
                        .font(.custom(Cnst.txt.fInterSemiBold, size: 16))
                        .foregroundColor(.N100)
                    Text("Ukuran \(prod.dimension)")
                        .font(.custom(Cnst.txt.fInterRegular, size: 12))
                        .foregroundColor(.N50)
                    Text("Price unit \(prod.unit)")
                        .font(.custom(Cnst.txt.fInterRegular, size: 10))
                        .foregroundColor(.N50)
                }
                Spacer(minLength: 0)
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        if let disc = prod.discount {
                            Text( String((prod.price.toInt * disc.replacingOccurrences(of: "%", with: "").toInt) / 100).toRupiah )
                                .strikethrough()
                                .font(.custom(Cnst.txt.fInterRegular, size: 14))
                                .foregroundColor(.N50)
                        }
                        Text(prod.price.toRupiah)
                            .font(.custom(Cnst.txt.fInterBold, size: 12))
                            .foregroundColor(.R100)
                    }
                    Spacer()
                    Button {
                        if let fi = coData.firstIndex(where: { $0.productCode == prod.productCode }) {
                            coData[fi].jumlah += 1
                        } else {
                            let dm = CheckoutRequest(productCode: prod.productCode,
                                                     productName: prod.productName,
                                                     price: prod.price,
                                                     currency: prod.currency,
                                                     dimension: prod.dimension,
                                                     unit: prod.unit,
                                                     jumlah: 1)
                            coData.append(dm)
                        }
                    } label: {
                        Text("Tambah")
                            .font(.custom(Cnst.txt.fInterSemiBold, size: 12))
                            .foregroundColor(.G100)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.G100, lineWidth: 1)
                            )
                    }
                }
            }
        }
        .frame(height: 100)
        .padding()
    }
}

struct List_View_Previews: PreviewProvider {
    static var previews: some View {
        ListView(listData: [])
    }
}
