// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// Ödev dosya adın BC<ÖğrenciNo>.sol olacak ama
// kontrat adını RectangleArea bırakıyoruz ki dokümandaki örnekle uyumlu olsun.
contract RectangleArea {
    // -----------------------------
    // State değişkenleri
    // -----------------------------
    uint256 private width;
    uint256 private height;

    bool private widthSet;
    bool private heightSet;

    // İsteğe bağlı biraz "değişiklik": event ve istatistik
    uint256 public updateCount;          // kaç kez width/height güncellendi
    address public lastUpdatedBy;        // en son kim güncelledi

    // -----------------------------
    // Event'ler (frontend'de ister kullan ister kullanma)
    // -----------------------------
    event WidthUpdated(uint256 newWidth, address indexed updatedBy);
    event HeightUpdated(uint256 newHeight, address indexed updatedBy);

    // -----------------------------
    // Width ayarlama (0'dan büyük olmalı)
    // -----------------------------
    function setWidth(uint256 w) public {
        require(w > 0, "Width must be greater than zero");

        width = w;
        widthSet = true;

        updateCount += 1;
        lastUpdatedBy = msg.sender;

        emit WidthUpdated(w, msg.sender);
    }

    // -----------------------------
    // Height ayarlama (0'dan büyük olmalı)
    // -----------------------------
    function setHeight(uint256 h) public {
        require(h > 0, "Height must be greater than zero");

        height = h;
        heightSet = true;

        updateCount += 1;
        lastUpdatedBy = msg.sender;

        emit HeightUpdated(h, msg.sender);
    }

    // -----------------------------
    // Alan hesaplama (sadece ikisi de set ise)
    // -----------------------------
    function area() public view returns (uint256) {
        require(widthSet, "Width not set yet");
        require(heightSet, "Height not set yet");
        return width * height;
    }

    // -----------------------------
    // Getter fonksiyonlar (ödevde de var)
    // -----------------------------
    function getWidth() public view returns (uint256) {
        return width;
    }

    function getHeight() public view returns (uint256) {
        return height;
    }

    // Küçük bonus: ikisi de set mi? (frontend'de istersen kullanırsın)
    function bothSet() public view returns (bool) {
        return widthSet && heightSet;
    }
}