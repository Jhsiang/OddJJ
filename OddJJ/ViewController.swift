//
//  ViewController.swift
//  OddJJ
//
//  Created by Jim Chuang on 2018/9/26.
//  Copyright © 2018年 nhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    let noOneWin = 0
    let p1Win = 1
    let p2Win = 2

    let takeMode = 0
    let addMode = 1
    let moveMove = 2

    @IBOutlet var myCollectionView: UICollectionView!

    @IBOutlet var p1BigView: UIView!
    @IBOutlet var p1MidView: UIView!
    @IBOutlet var p1SmallView: UIView!

    @IBOutlet var p2BigView: UIView!
    @IBOutlet var p2MidView: UIView!
    @IBOutlet var p2SmallView: UIView!

    @IBOutlet var p1BigIV: UIImageView!
    @IBOutlet var p1MidIV: UIImageView!
    @IBOutlet var p1SmallIV: UIImageView!

    @IBOutlet var p2BigIV: UIImageView!
    @IBOutlet var p2MidIV: UIImageView!
    @IBOutlet var p2SmallIV: UIImageView!

    var p1BigBtn = UIButton()
    var p1MidBtn = UIButton()
    var p1SmaBtn = UIButton()
    var p2BigBtn = UIButton()
    var p2MidBtn = UIButton()
    var p2SmaBtn = UIButton()
    var ivArr = Array<Array<UIImageView>>()
    var imageArr = Array<Array<UIImage?>>()

    var select = Select()
    var cellSelect = -1
    var selectColorP1 = UIColor()
    var selectColorP2 = UIColor()
    var selectColorCell = UIColor()
    var tokenOwerArr = [[2,2,2],[2,2,2]] // [smal,mid,big]

    let arr = [[Token(),Token(),Token()],
               [Token(),Token(),Token()],
               [Token(),Token(),Token()]]

    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self

        selectColorP1 = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.4)
        selectColorP2 = UIColor(red: 0.4, green: 0.2, blue: 0.1, alpha: 0.4)
        selectColorCell = UIColor(red: 0.3, green: 0.7, blue: 1, alpha: 0.4)

        ivArr = [[p1SmallIV,p1MidIV,p1BigIV],[p2SmallIV,p2MidIV,p2BigIV]]
        let p1ZeroImage = UIImage(named: "")
        let p1OneImage = UIImage(named: "p3-big1.png")
        let p1TwoImage = UIImage(named: "p3-big2.png")
        let p2ZeroImage = UIImage(named: "")
        let p2OneImage = UIImage(named: "p4-big1.png")
        let p2TwoImage = UIImage(named: "p4-big2.png")

        imageArr = [[p1ZeroImage,p1OneImage,p1TwoImage],[p2ZeroImage,p2OneImage,p2TwoImage]]

        refreshSellectBtn()

        p1BigBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: p1BigView.frame.size))
        p1MidBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: p1MidView.frame.size))
        p1SmaBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: p1SmallView.frame.size))
        p2BigBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: p2BigView.frame.size))
        p2MidBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: p2MidView.frame.size))
        p2SmaBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: p2SmallView.frame.size))

        p1BigBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        p1MidBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        p1SmaBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        p2BigBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        p2MidBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        p2SmaBtn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)

        p1BigView.addSubview(p1BigBtn)
        p1MidView.addSubview(p1MidBtn)
        p1SmallView.addSubview(p1SmaBtn)
        p2BigView.addSubview(p2BigBtn)
        p2MidView.addSubview(p2MidBtn)
        p2SmallView.addSubview(p2SmaBtn)
    }

    func checkVector(arr:Array<Array<Token>>){

        var winResut = 0

        if arr[0][0].showBelong() != 0 && arr[0][0].showBelong() == arr[0][1].showBelong() && arr[0][0].showBelong() == arr[0][2].showBelong(){
            winResut = arr[0][0].showBelong()
        }
        if arr[1][0].showBelong() != 0 && arr[1][0].showBelong() == arr[1][1].showBelong() && arr[1][0].showBelong() == arr[1][2].showBelong(){
            winResut = arr[1][0].showBelong()
        }
        if arr[2][0].showBelong() != 0 && arr[2][0].showBelong() == arr[2][1].showBelong() && arr[2][0].showBelong() == arr[2][2].showBelong(){
            winResut = arr[2][0].showBelong()
        }

        if arr[0][0].showBelong() != 0 && arr[0][0].showBelong() == arr[1][0].showBelong() && arr[0][0].showBelong() == arr[2][0].showBelong(){
            winResut = arr[0][0].showBelong()
        }
        if arr[0][1].showBelong() != 0 && arr[0][1].showBelong() == arr[1][1].showBelong() && arr[0][1].showBelong() == arr[2][1].showBelong(){
            winResut = arr[0][1].showBelong()
        }
        if arr[0][2].showBelong() != 0 && arr[0][2].showBelong() == arr[1][2].showBelong() && arr[0][2].showBelong() == arr[2][2].showBelong(){
            winResut = arr[0][2].showBelong()
        }

        if arr[0][0].showBelong() != 0 && arr[0][0].showBelong() == arr[1][1].showBelong() && arr[0][0].showBelong() == arr[2][2].showBelong(){
            winResut = arr[0][0].showBelong()
        }
        if arr[0][2].showBelong() != 0 && arr[0][2].showBelong() == arr[1][1].showBelong() && arr[0][2].showBelong() == arr[2][0].showBelong(){
            winResut = arr[0][2].showBelong()
        }

        let title:String = winResut == p1Win ? "P1 win" : "P2 win"
        if winResut == p1Win || winResut == p2Win{

            let alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertView.addAction(action)

            let winImage = UIImage(named: winResut == p1Win ? "p3-big.png" : "p4-big.png")!
            let imageViewLeft = UIImageView(frame: CGRect(x: alertView.view.frame.width/2-20, y: 0, width: 70, height: 70))
            let imageViewRight = UIImageView(frame: CGRect(x: 20, y: 0, width: 70, height: 70))
            imageViewLeft.image = winImage
            imageViewRight.image = winImage
            alertView.view.addSubview(imageViewLeft)
            alertView.view.addSubview(imageViewRight)

            self.present(alertView, animated: true, completion: nil)
        }
    }

    //MARK: - Button Click
    func refreshSellectBtn(){
        let btnArr = [[p1SmaBtn,p1MidBtn,p1BigBtn],[p2SmaBtn,p2MidBtn,p2BigBtn]]
        for player in 0...1{
            for power in 0...2{

                let num = tokenOwerArr[player][power]
                ivArr[player][power].image = imageArr[player][num]

                if num == 0 {
                    btnArr[player][power].isEnabled = false
                }else{
                    btnArr[player][power].isEnabled = true
                }
            }
        }
    }

    @IBAction func btnClick(_ sender: UIButton) {
        if select.mod == moveMove{
            return
        }

        switch sender {
        case p1BigBtn:
            if select.belong == 1 && select.power == 3{
                select.belong = 0
                select.power = 0
            }else{
                select.belong = 1
                select.power = 3
                UIView.animate(withDuration: 0.5) {
                    self.p1BigView.backgroundColor = self.selectColorP1
                }
                UIView.animate(withDuration: 1) {
                    self.p1BigView.backgroundColor = UIColor.clear
                }
            }
        case p1MidBtn:
            if select.belong == 1 && select.power == 2{
                select.belong = 0
                select.power = 0
            }else{
                select.belong = 1
                select.power = 2
                UIView.animate(withDuration: 0.5) {
                    self.p1MidView.backgroundColor = self.selectColorP1
                }
                UIView.animate(withDuration: 1) {
                    self.p1MidView.backgroundColor = UIColor.clear
                }
            }
        case p1SmaBtn:
            if select.belong == 1 && select.power == 1{
                select.belong = 0
                select.power = 0
            }else{
                select.belong = 1
                select.power = 1
                UIView.animate(withDuration: 0.5) {
                    self.p1SmallView.backgroundColor = self.selectColorP1
                }
                UIView.animate(withDuration: 1) {
                    self.p1SmallView.backgroundColor = UIColor.clear
                }
            }
        case p2BigBtn:
            if select.belong == 2 && select.power == 3{
                select.belong = 0
                select.power = 0
            }else{
                select.belong = 2
                select.power = 3

                UIView.animate(withDuration: 0.5) {
                    self.p2BigView.backgroundColor = self.selectColorP2
                }
                UIView.animate(withDuration: 1) {
                    self.p2BigView.backgroundColor = UIColor.clear
                }
            }
        case p2MidBtn:
            if select.belong == 2 && select.power == 2{
                select.belong = 0
                select.power = 0
            }else{
                select.belong = 2
                select.power = 2
                UIView.animate(withDuration: 0.5) {
                    self.p2MidView.backgroundColor = self.selectColorP2
                }
                UIView.animate(withDuration: 1) {
                    self.p2MidView.backgroundColor = UIColor.clear
                }
            }
        case p2SmaBtn:
            if select.belong == 2 && select.power == 1{
                select.belong = 0
                select.power = 0
            }else{
                select.belong = 2
                select.power = 1
                UIView.animate(withDuration: 0.5) {
                    self.p2SmallView.backgroundColor = self.selectColorP2
                }
                UIView.animate(withDuration: 1) {
                    self.p2SmallView.backgroundColor = UIColor.clear
                }
            }
        default:
            break
        }

        select.mod = addMode
    }

    @IBAction func cleanClick(_ sender: UIBarButtonItem) {
        for i in arr{
            for j in i{
                j.clean()
            }
        }
        tokenOwerArr = [[2,2,2],[2,2,2]]
        select.belong = 0
        select.power = 0
        select.mod = takeMode
        refreshSellectBtn()
        self.myCollectionView.reloadData()
    }


    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let row:Int = indexPath.item / 3
        let colum:Int = indexPath.item % 3
        cellSelect = indexPath.item

        // Move status
        if select.belong == 0 && select.power == 0 && select.mod == takeMode{

            // 要有東西可移
            guard arr[row][colum].showBelong() != 0 || arr[row][colum].showPower() != 0 else{
                return
            }

            select.belong = arr[row][colum].showBelong()
            select.power = arr[row][colum].showPower()
            select.mod = moveMove
            if arr[row][colum].removeToken(){
                self.myCollectionView.reloadData()
                checkVector(arr: arr)
            }
        }

        else if select.mod == moveMove{
            if arr[row][colum].setToken(setBelong: select.belong, setPower: select.power){

                self.myCollectionView.reloadData()
                checkVector(arr: arr)
                select.belong = 0
                select.power = 0
                select.mod = takeMode

            }else{
                return
            }

        }

        // New added status
        else if select.mod == addMode{

            if arr[row][colum].setToken(setBelong: select.belong, setPower: select.power){
                self.myCollectionView.reloadData()
                checkVector(arr: arr)

                let player = select.belong - 1
                let pwr = select.power - 1
                if tokenOwerArr[player][pwr] > 0 {
                    tokenOwerArr[player][pwr] -= 1
                }
                refreshSellectBtn()
                select.belong = 0
                select.power = 0
                select.mod = takeMode
            }else{
                select.belong = 0
                select.power = 0
                select.mod = takeMode
                return
            }

        }
    }


    //MARK: - UICollectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: myCollectionView.frame.width/3, height: myCollectionView.frame.height/3)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if cellSelect == indexPath.item{
            UIView.animate(withDuration: 0.25) {
                cell.backgroundColor = self.selectColorCell
            }
            UIView.animate(withDuration: 0.5) {
                cell.backgroundColor = UIColor.clear
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_main", for: indexPath) as! MainCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 22
        cell.layer.borderColor = UIColor(red: 0.4, green: 0.8, blue: 0.2, alpha: 1).cgColor

        let row:Int = indexPath.item / 3
        let colum:Int = indexPath.item % 3


        let imageNameArr = ["p3-big.png","p4-big.png"]
        let player = arr[row][colum].showBelong()
        let power = arr[row][colum].showPower()
        if player > 0 && power > 0 {
            let image = UIImage(named: imageNameArr[player-1])
            let smallFrame = CGRect(x: cell.frame.width*3/8, y: cell.frame.height*3/8, width: cell.frame.width/4, height: cell.frame.height/4)
            let midFrame = CGRect(x: cell.frame.width/4, y: cell.frame.width/4, width: cell.frame.width/2, height: cell.frame.height/2)
            let bigFrame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            switch power{
            case 1:
                cell.cellIV.frame = smallFrame
            case 2:
                cell.cellIV.frame = midFrame
            case 3:
                cell.cellIV.frame = bigFrame
            default:
                cell.cellIV.image = UIImage()
            }
            cell.cellIV.image = image
        }else{
            cell.cellIV.image = UIImage()
        }
        cell.label.text = ""//arr[row][colum].showText()

        return cell
    }


}

