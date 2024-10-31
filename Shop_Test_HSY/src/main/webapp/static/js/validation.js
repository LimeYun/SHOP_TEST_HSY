/**
 *  유효성 검사 
 */
function checkJoin() {
	let form = document.joinForm
		
	let id = form.id.value
	let pw = form.pw.value
	
	
	// 1. 아이디는 필수값, 6~20자 이내
	// 아이디 입력여부 검증
	if( id == "" ) {
		alert('아이디를 입력해주세요')
		form.id.focus()			// id input 태그에 포커스
		return false
	}
	
	// 아이디 글자 수 검증
	if( id.length < 6 || id.length > 20 ) {
		alert('아이디는 6~20자 이내로 입력 가능합니다.')
		form.id.select()		// id 입력 값을 선택
		return false
	}
	// 2. 비밀번호는 필수값, 6자 이상
	// 비밀번호 입력여부 검증
	if( pw == "" ) {
		alert('비밀번호를 입력해주세요')
		form.pw.focus()			// id input 태그에 포커스
		return false
	}
	
	// 비밀번호 글자 수 검증
	if( pw.length < 6 ) {
		alert('비밀번호는 6자 이상으로 입력해야합니다.')
		form.id.select()		// id 입력 값을 선택
		return false
	}
	
	
	// 3. 이름은 필수값, 첫글자는 숫자로 사용 불가
	let name = form.name.value
	
	if( name == "" ) {
		alert('이름을 입력해주세요')
		form.name.focus()
		return false
	}
	
	// isNaN() : 숫자가 아니면 true
	if( !isNaN( name.substr(0, 1) ) ) {
		alert('이름은 숫자로 시작할 수 없습니다.')
		form.name.select()
		return false
	}

	return true
}

function checkProduct() {
	let form = document.product
	let productId = form.productId
	let name = form.name
	let unitPrice = form.unitPrice
	let unitsInStock = form.unitsInStock
	
	let msg = ''
	
	// 상품아이디 체크
	// - P숫자 6자리
	let productIdCheck = /^P[0-9]{6}$/
	msg = '상품 아이디는 "P6자리" 로 입력해주세요' 
	if( !check(productIdCheck, productId, msg) ) return false
	
	// 상품명 체크
	// - 2글자 이상 20글자 이하
	let nameCheck = /^.{2,20}$/
	msg = '상품명은 2~20자 이내로 입력해주세요'
	if( !check(nameCheck, name, msg) ) return false
	
	// 가격 체크
	// - 숫자로 1글자 이상
	let priceCheck = /^\d{1,}$/
	msg = '가격은 1글자 이상의 숫자로 입력해주세요'
	if( !check(priceCheck, unitPrice, msg) ) return false
	
	// 재고 체크
	// - 숫자로 1글자 이상
	let stockCheck = /^\d{1,}$/
	msg = '재고는 1글자 이상의 숫자로 입력해주세요'
	if( !check(stockCheck, unitsInStock, msg) ) return false
	
	return true
}

// 정규표현식 유효성 검사 함수
function check(regExp, element, msg) {
	
	if( regExp.test(element.value) ) {
		return true
	}
	alert(msg)
	element.select()
	element.focus()
	return false
}