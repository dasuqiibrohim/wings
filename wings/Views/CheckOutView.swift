//
//  CheckOutView.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

struct CheckOutView: View {
    @State var nampanData: [CheckoutRequest]
    @State private var showShmrr: Bool = false
    @State private var total: Int = 0
    
    
    var body: some View {
        VStack(spacing: 0) {
            //Header
            Text("Checkout")
                .font(.custom(Cnst.txt.fInterBold, size: 16))
                .foregroundColor(.N100)
                .padding()
            Divider()
            
            if nampanData.count > 0 {
                ScrollView(showsIndicators: false) {
                    ForEach($nampanData) { checkout in
                        NampanCardView(co: checkout)
                    }
                }
                .redacted(reason: showShmrr ? .placeholder: [])
            } else {
                ListNotFoundView()
            }
            
            
            Divider()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total")
                        .font(.custom(Cnst.txt.fInterRegular, size: 12))
                        .foregroundColor(.N50)
                    Text(CountTotalPrice())
                        .font(.custom(Cnst.txt.fInterBold, size: 16))
                        .foregroundColor(.N100)
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Buat Pesanan")
                        .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                        .foregroundColor(.N0)
                        .padding(.vertical)
                        .padding(.horizontal, 32)
                        .background(Color.G100)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .onAppear {
            showShmrr = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.showShmrr = false
            }
        }
    }
    
    private func ListNotFoundView() -> some View {
        VStack(spacing: 24) {
            Image(Cnst.img.listEmpty)
            Text("Belum ada yang di Checkout nih..")
                .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                .foregroundColor(.N50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private func CountTotalPrice() -> String {
        var rest = 0
        for co in nampanData {
            rest += (co.jumlah * co.price.toInt)
        }
        return String(rest).toRupiah
    }
}

struct NampanCardView: View {
    @Binding var co: CheckoutRequest
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(co.productCode)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(co.productName.capitalized)
                        .font(.custom(Cnst.txt.fInterSemiBold, size: 16))
                        .foregroundColor(.N100)
                        .lineLimit(1)
                    Text("Ukuran \(co.dimension)")
                        .font(.custom(Cnst.txt.fInterRegular, size: 12))
                        .foregroundColor(.N50)
                    Text("Price unit \(co.unit)")
                        .font(.custom(Cnst.txt.fInterRegular, size: 10))
                        .foregroundColor(.N50)
                }
                Spacer(minLength: 0)
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Sub Total")
                            .font(.custom(Cnst.txt.fInterRegular, size: 10))
                            .foregroundColor(.N50)
                        Text(String(co.price.toInt * co.jumlah).toRupiah)
                            .font(.custom(Cnst.txt.fInterBold, size: 12))
                            .foregroundColor(.R100)
                    }
                    Spacer()
                    HStack(spacing: 12) {
                        Button {
                            if co.jumlah > 1 {
                                co.jumlah -= 1
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.N50)
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.N100)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        
                        Text("\(co.jumlah)")
                            .font(.custom(Cnst.txt.fInterSemiBold, size: 16))
                            .foregroundColor(.N100)
                        
                        Button {
                            co.jumlah += 1
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.G100)
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.N0)
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 100)
        .padding()
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(nampanData: [])
    }
}
