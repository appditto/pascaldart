
import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

void main() {
  group('common.coding.pascal.keys.PrivatKeyCoder', () {
    PrivateKeyCoder coder;
    List<Map<String, String>> curve714;
    List<Map<String, String>> curve715;
    List<Map<String, String>> curve716;
    List<Map<String, String>> curve729;

    setUp(() {
      coder = PrivateKeyCoder();
      curve714 = [
        {
          "encrypted": "53616C7465645F5FED4A37ECAD2BF13FF24A66DDA299A57632520447B28B9E642C4B2A301CACC217FBD7713F6282C20CCCFDC5FFD2AB93A8E48D8C2C81704D36",
          "password": "test1234",
          "b58_pubkey": "3GhhbopDPbi883HVV6Hxun6q6AN43CB1yUD9km64cDoZMhgM1KkLy3N41vT1H1zqw4kHdqM64NHMSpSNviVkUP7fCrisZwYzb89dDs",
          "enc_privkey": "CA02200046B7A086680D208272F6982F574FE226042F30D049F9A226283FC3346506411D"
        },
        {
          "encrypted": "53616C7465645F5FB3431FD46EB80DE81273E0181F170552DE01506A9C91D47269312A81841C82B7F55014CEA471A7D8D3187DA2D10B4F9A8481DA7911CCC1A2",
          "password": "test333",
          "b58_pubkey": "3GhhbouATXfrARGuHA8ymY2DoPYjKY9i7xBvdpyHjNWtWwdphWwkSaKaKx3tRNV47yGFhnkLZbJkL8crjE129FHUvrFod6dZQt3H8C",
          "enc_privkey": "CA02200066C8426FA1DC0980DBDEE7F8656AE6FCA9EF746975E3FFB9EB425B53638C0175"
        },
        {
          "encrypted": "53616C7465645F5FFA7AEBA0EB6776EA2D3BCDADBD5908F1B032B78DA75193A9D8040B94E49CA95920E130BD0CB7603DB72D2639AEA95E8D75CB31AEBBD6EA19",
          "password": "techworker",
          "b58_pubkey": "3GhhborMr2ApiQC19ah4EMkFBj46WymwABvqJ8hMwVkVA5TB58Dver6cfosn8zVKpNnJZCsn8HTdnSobopiMgVe4R8S5ap49NvNsEP",
          "enc_privkey": "CA02200046D101363B3330D65373A70F6E47BB7745FC8EE1F9B3F71992D6B82648158D73"
        }
      ];
      curve715 = [
        {
          "encrypted": "53616C7465645F5FE1C85F75A6E3D75EF916DD9F60E14660F9C63A8AE407060EAA6F7CF373CB830B6E50D27EC46B013602A75305BD3D6433669607846D7335C9A1849664E8A35DD8E5FDECF40CAE5325",
          "password": "test1234",
          "b58_pubkey": "gD8AW4fgASg1cneBp3csnKeF2x3F2q8LpT4VFCyjEBPG8FraaoRHRJfFtBaGSQH3Y2tqqjJbjAAFWvPgVpL5RvA1xokiN9oVeARsi5jPYdmx7FxrZ1XrtyrDPQPArCJyHsq11wqJVhMgfiAjJ",
          "enc_privkey": "CB02300015B2267604593566FEB5292B32F60C3399540C7EB83F3AABB7255BC73B3809E2B742BB971B6274DF452862D6D902466B"
        },
        {
          "encrypted": "53616C7465645F5F28F251B908FECEA1DFA33CB727F44E43E95D67DEE66536DFB08D20DF62B69474FF8C36167B8BBB9C5B00D042EC338FFE5A701A8A36F7087FB49007110207B1F880B876467D17F195",
          "password": "blabla",
          "b58_pubkey": "gD8AW39i8QV2g57X1F19CGHPF8b6oQcDqw9Q5LAq4X6JofJsg1hJhN1i7yhhkeGZQW86bWKeWSssTZVUvmxU4yFu5ivPpU5qMQk6oHofMKKwmoY4uLjzGWnmCsmNdbtK7k6MnhHkeDJqZiRwt",
          "enc_privkey": "CB023000FCABEC25AAA049A524CEA1D69360711C1EB4E83D86D2CB45B0EFA1F69B218CCABE3CF0A16AE8ED170919B7B39D1C390E"
        },
        {
          "encrypted": "53616C7465645F5F7C4731B8A43D75E23C7F77FB51C44DCCA59394ED2B06F1291849D248AB096A32C93A3E76F32395158E9624AFF2B6AB543CD5C0DCC3735E4879A1E7063F74C11251618A192082F9F4",
          "password": "zulu55",
          "b58_pubkey": "gD8AW3uCN1tF8FRNNvnGMcSdgNS7uzQErW4mHXpBgG4RCcLhZ2VcGAUuqiW6MrYV4Fsxfbo5n3ToRmn7WaMGCzMFcJX5SCrTY4fvEGrE2q5XTw2gasapYvRYe1c8UKmQoxE6VmKgvDkaiVC51",
          "enc_privkey": "CB023000225EDA615DBF3F296B295E76454444024E5F1CF17D5275135C00CDCADF966889890F5618874D95A9EEFF22B6DDCF9C4A"
        }
      ];
      curve716 = [
        {
          "encrypted": "53616C7465645F5FD5B6C81AE89043F4ECE78CD21F68BFD0FBCC3C6E5BF4BD10B199D53F1DE8C8DFC6FF8CCE3AE309734C268337B1E80A5C70256480482EC8D99D52A8B448BD016C72D3FA482DE6C2F4CBBF604B2D3A7CBB78745AA9057486A0",
          "password": "test1234",
          "b58_pubkey": "JJj2GZDjhAHPKfyJ4GyEMhFNfUZPAUFe7oqfChPY5HinqNY5NPsCydcY2XEw8iwqhxSuaoAg6hf7qFagZJQ6HTYCGdTdgBxNangcV4ZcbcKwesZ5QmX6sVvLDPvGosfjk8LnrVgVhwJnv26dzKbPceNUzPHR8Pm2zwx6kjESRa3bKajupKngZGYyGmVJNuuyJ",
          "enc_privkey": "CC02420001F4C77C1DC868F62A96DD74343B9C03C594F6E42DA3A0139D6988D45D75FBC167E6D98D1F101D4FE8F8D58514F7571399E4548A017645609F5F575176849A38335B"
        },
        {
          "encrypted": "53616C7465645F5FA78798633EC647B4BCCC1240730C24E5852B649C3930EF7F9703018D4ED62000B254A875A021B32CFB7B8E87C2C19099CF6E7F1F9E76556F4391A00B118EB6A8EECCFB4CA19C4333B2A7393EF1A88D200D257E3A32DC4C0B",
          "password": "techworker",
          "b58_pubkey": "JJj2A5Fyw46yWMLegHqvHpUgeBgx957FK2kCRy4nA2qYGbmwMP9tNHnaVJFX6Yha8bQPbNyjLtdrjsqgTFRbFKAWhzx6s9hCjCmVwUsw1ZrE8MB1MkrqgobAr4xxZNmw4i3osKvMwE9LWafSQC5DWCRsx636u6h1Vdpt1CeGthDZfRU35DcKusZ7ZD2W2Pfns",
          "enc_privkey": "CC024100E9551B5AD9D9084DD878E224BE718E2929892FC03A5420DCC9A8B9AB5260B47A039D3838DB32D003141AEB1C2F53A285A78470D65AAD2222B2A4C9B279AF76CBF1"
        },
        {
          "encrypted": "53616C7465645F5FD8FEC5F2D15CF8997170913FF9F1D715481431196F35BCB60B8A127440D0B7E9D67F908FF857E4EF7B9EFA6BC5A4F8B8FB8F1AD40B9642A2E20BDC5F1B08C3D6128BE2F67CCBAA2CD2C91E287CB4FA298317EBCC872919EF",
          "password": "zulu123",
          "b58_pubkey": "JJj2GZDo19rm39iih31cyJns2PBUqkTqFvpLZ6tucYNrjf8e9yWr4hckXP9C85x4zBRNJk1YqA6HSkX9AaTUearmYs9qFVzRzwX7X2gEt1gFhHq1dJaeLmDyRXVbd7cmiuxD6tjjXS7V4Jt3A5esgHTpZRQ6PXReDkWmx4fmcURcHFiWwtwWdQrz5ZTEQrQ3r",
          "enc_privkey": "CC024100231B27482A4ED27F9CECBFA1D6E610146852D720A5F7623E24D348499B46F31E02B46572D55A7C97CD303D4361242B11A5789C2FEB9A793B0C285B5DF4EBC08984"
        }
      ];
      curve729 = [
        {
          "encrypted": "53616C7465645F5F096AF812ED1B1275E123BAF0F351A50554CC62C50C6181AD6313B5E6A319F6ABAF9A1CC29FFA47162355E5A731F379420B7FB6ACC92F9F82",
          "password": "test1234",
          "b58_pubkey": "2jR5AN61cbT1MmPmhdBPCcYCUidSf4hSzKHycfw6Kk8DFqcxD4MS1y7YezmsoC19S4QJmQvwnDnVDjnHgRaeX8PyE1pWvFzBWVnDBNuawD1wQ9iaa",
          "enc_privkey": "D9022300252A9478A7C732CE80E1BE5E2F529050F8521D8F7FEC3C0C8EA2936307244AF9F38E55"
        },
        {
          "encrypted": "53616C7465645F5FE327D1F4C88764F6D6F5CD48BC563D5E53D31E641AF18BAE52DDCE43AE7252D2BA294BB1D1F7D6C66195D2021C77B72E95C36D659ABC0BBF",
          "password": "techworker",
          "b58_pubkey": "2jR5AN5umYFQ2Xgh2p4Scva1NTbipBXtDe4NgTZPd7SSoQkRkPBp6b7AizVZ5nXLboHH6h4fDhAxmUCVkfZ6NGv7GNuoRnqQ1WcwnEEEf2NyiBmVc",
          "enc_privkey": "D9022300BD97C143CB26947DE0DF445972F929C1C76DA86B2B33C5B486C8AE926872D77DB4042D"
        },
        {
          "encrypted": "53616C7465645F5F36404950AA92E7632F88BE903B9DF3DBFA5CDDE67E776655C95773F80ED982DB55917A685B50F514F813D091C6768280E98C66F996CB7127",
          "password": "zandura",
          "b58_pubkey": "PkWwgfjhzQWM3sBjXFWRdXAq6ge2Wrr4vXGMp3vMTzj3yVbdqhWxfTwo6ySRAiVP39LZRoH6T9sZq7F5bCHMTD7b92fEynFwSV6xGqTDikNSnoc",
          "enc_privkey": "D9022400011FC78E156FFB72C1C830740D34BD711DBFF03AD0F2A272D160D41A28FCB0C1000CBFED"
        }
      ];
    });
    test('can decode a pascalcoin private key', () {
      curve714.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 714);
      });
      curve715.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 715);
      });
      curve716.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 716);
      });
      curve729.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(pk.curve.id, 729);
      });
    });
    test('can encode a pascalcoin private key', () {
      curve714.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(Util.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
      curve715.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(Util.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
      curve716.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(Util.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
      curve729.forEach((c) {
        PrivateKey pk = coder.decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
        expect(coder.encodeToHex(pk), c['enc_privkey']);
        expect(Util.byteToHex(coder.encodeToBytes(pk)), c['enc_privkey']);
      });
    });
  });
}
