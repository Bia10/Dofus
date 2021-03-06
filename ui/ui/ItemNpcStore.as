﻿package ui
{
    import d2hooks.ClickItemStore;
    import d2hooks.ClickItemInventory;
    import d2hooks.ObjectDeleted;
    import d2hooks.SellOk;
    import d2hooks.BuyOk;
    import d2actions.ExchangeSell;
    import d2actions.ExchangeBuy;
    import d2components.GraphicContainer;

    public class ItemNpcStore extends BasicItemCard 
    {

        private var _mode:Boolean;
        private var _token:int;
        public var tx_inputPrice:Object;


        override public function main(params:Object=null):void
        {
            super.main(params);
            sysApi.addHook(ClickItemStore, this.onClickItemStore);
            sysApi.addHook(ClickItemInventory, this.onClickItemInventory);
            sysApi.addHook(ObjectDeleted, this.onObjectDeleted);
            sysApi.addHook(SellOk, this.onSellOk);
            sysApi.addHook(BuyOk, this.onBuyOk);
            this.tx_inputPrice.visible = false;
            super.input_quantity.numberMax = 999999999;
        }

        override public function unload():void
        {
            super.unload();
        }

        override public function onRelease(target:Object):void
        {
            var _local_2:RegExp;
            var _local_3:String;
            switch (target)
            {
                case btn_valid:
                    _local_2 = /^\s*(.*?)\s*$/g;
                    input_quantity.text = input_quantity.text.replace(_local_2, "$1");
                    input_price.text = input_price.text.replace(_local_2, "$1");
                    _local_3 = "";
                    if (this._token)
                    {
                        _local_3 = ("x " + dataApi.getItemName(this._token));
                    };
                    if (this._mode)
                    {
                        if ((((utilApi.stringToKamas(input_quantity.text, "") <= 0)) || ((utilApi.stringToKamas(input_quantity.text, "") > _currentObject.quantity))))
                        {
                            modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.error.invalidQuantity"), [uiApi.getText("ui.common.ok")]);
                            break;
                        };
                        if (!(_local_3))
                        {
                            modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.bidhouse.doUSellItemWithoutTax", ((input_quantity.text + " x ") + _currentObject.name), utilApi.kamasToString(_currentPrice), utilApi.kamasToString((_currentPrice * utilApi.stringToKamas(input_quantity.text, ""))), utilApi.kamasToString(0)), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onConfirmSellObject, this.onCancel], this.onConfirmSellObject, this.onCancel);
                        }
                        else
                        {
                            modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.bidhouse.doUSellItemWithoutTax", ((input_quantity.text + " x ") + _currentObject.name), utilApi.kamasToString(_currentPrice, _local_3), utilApi.kamasToString((_currentPrice * utilApi.stringToKamas(input_quantity.text, "")), _local_3), utilApi.kamasToString(0)), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onConfirmSellObject, this.onCancel], this.onConfirmSellObject, this.onCancel);
                        };
                    }
                    else
                    {
                        if (utilApi.stringToKamas(input_quantity.text, "") <= 0)
                        {
                            modCommon.openPopup(uiApi.getText("ui.common.error"), uiApi.getText("ui.error.invalidQuantity"), [uiApi.getText("ui.common.ok")]);
                            break;
                        };
                        if (_local_3 == "")
                        {
                            modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.bidhouse.doUBuyItemBigStore", ((input_quantity.text + " x ") + _currentObject.name), utilApi.kamasToString(_currentPrice), utilApi.kamasToString((_currentPrice * utilApi.stringToKamas(input_quantity.text, "")))), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onConfirmBuyObject, this.onCancel], this.onConfirmBuyObject, this.onCancel);
                        }
                        else
                        {
                            modCommon.openPopup(uiApi.getText("ui.popup.warning"), uiApi.getText("ui.bidhouse.doUBuyItemBigStore", ((input_quantity.text + " x ") + _currentObject.name), utilApi.kamasToString(_currentPrice, _local_3), utilApi.kamasToString((_currentPrice * utilApi.stringToKamas(input_quantity.text, "")), _local_3)), [uiApi.getText("ui.common.yes"), uiApi.getText("ui.common.no")], [this.onConfirmBuyObject, this.onCancel], this.onConfirmBuyObject, this.onCancel);
                        };
                    };
                    break;
            };
        }

        private function onConfirmSellObject():void
        {
            sysApi.sendAction(new ExchangeSell(_currentObject.objectUID, utilApi.stringToKamas(input_quantity.text, "")));
        }

        private function onConfirmBuyObject():void
        {
            sysApi.sendAction(new ExchangeBuy(_currentObject.objectGID, utilApi.stringToKamas(input_quantity.text, "")));
        }

        private function onCancel():void
        {
        }

        public function onObjectDeleted(pObject:Object):void
        {
            if (_currentObject.objectUID == pObject.objectUID)
            {
                _currentObject = null;
                super.hideCard();
            };
        }

        public function onClickItemStore(pItem:Object, token:int):void
        {
            this._mode = false;
            sysApi.log(2, "clic magasin");
            onObjectSelected(pItem.item);
            ctr_inputPrice.visible = false;
            btn_lbl_btn_valid.text = uiApi.getText("ui.common.buy");
            var item:Object = dataApi.getItem(pItem.item.objectGID);
            _currentPrice = pItem.price;
            this._token = token;
            if (token)
            {
                lbl_price.text = utilApi.kamasToString(_currentPrice, "");
            }
            else
            {
                lbl_price.text = utilApi.kamasToString(_currentPrice);
            };
            input_quantity.text = "1";
            input_quantity.focus();
            input_quantity.setSelection(0, 8388607);
            if (token)
            {
                lbl_totalPrice.text = utilApi.kamasToString(_currentPrice, "");
            }
            else
            {
                lbl_totalPrice.text = utilApi.kamasToString(_currentPrice);
            };
        }

        public function onClickItemInventory(pItem:Object=null):void
        {
            var item:Object;
            var price:uint;
            this._mode = true;
            if (this._token == 0)
            {
                sysApi.log(2, "clic inventaire");
                onObjectSelected(pItem);
                ctr_inputPrice.visible = false;
                btn_lbl_btn_valid.text = uiApi.getText("ui.common.sell");
                if (pItem != null)
                {
                    item = dataApi.getItem(pItem.objectGID);
                    price = 0;
                    _currentPrice = item.price;
                    if (_currentPrice > 0)
                    {
                        if ((_currentPrice / TradeCenter.SELLING_RATIO) < 1)
                        {
                            price = 1;
                        }
                        else
                        {
                            price = Math.floor((_currentPrice / TradeCenter.SELLING_RATIO));
                        };
                    };
                    _currentPrice = price;
                    lbl_price.text = utilApi.kamasToString(_currentPrice);
                    input_quantity.text = "1";
                    input_quantity.focus();
                    input_quantity.setSelection(0, 8388607);
                    lbl_totalPrice.text = utilApi.kamasToString(_currentPrice);
                };
            };
        }

        override public function onChange(target:GraphicContainer):void
        {
            var quantity:int;
            if (target == input_quantity)
            {
                quantity = utilApi.stringToKamas(input_quantity.text);
                if (this._mode)
                {
                    if (quantity > _currentObject.quantity)
                    {
                        input_quantity.text = _currentObject.quantity;
                        quantity = _currentObject.quantity;
                    };
                };
                if (this._token)
                {
                    lbl_totalPrice.text = utilApi.kamasToString((_currentPrice * quantity), "");
                }
                else
                {
                    lbl_totalPrice.text = utilApi.kamasToString((_currentPrice * quantity));
                };
                if (!(this._mode))
                {
                    super.checkPlayerFund(quantity, this._token);
                }
                else
                {
                    super.checkPlayerFund(0);
                };
            };
        }

        private function onSellOk():void
        {
            hideCard();
        }

        private function onBuyOk():void
        {
            hideCard();
        }


    }
}//package ui

