const pay = () => {
  // ↓PAY.JPのライブラリを使い、用意したHTML要素をフォームと置き換える
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY);// PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  // ↑PAY.JPのライブラリを使い、用意したHTML要素をフォームと置き換える


  const submit = document.getElementById("button");

  submit.addEventListener("click", (e) => {
    e.preventDefault();

    // ↓トークン化の処理
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // ↓クレジットカードの情報のみ削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      // ↑クレジットカードの情報のみ削除
        // ↓最後にサーバーサイドにフォームの情報を送信
        document.getElementById("charge-form").submit();
        // ↑最後にサーバーサイドにフォームの情報を送信
    });
    // ↑トークン化の処理

  });
};

window.addEventListener("load", pay);