//
//  PlacesManager.swift
//  Nano 3
//
//  Created by Eduardo Stefanel Paludo on 26/09/23.
//

import Foundation

class PlacesManager {
    // static var places = [Place]()
    
    static var places = [
        Place(
            name: "Jardim Botânico",
            image: "jardimBotanico1",
            desc: "O Jardim Botânico de Curitiba é um dos principais pontos turísticos da cidade de Curitiba. Localiza-se no bairro Jardim Botânico. Em 2007 foi o monumento mais votado numa eleição para escolha das Sete Maravilhas do Brasil, promovido pelo site Mapa-Mundi. Inaugurado em 5 de outubro de 1991, seu nome oficial (J.B. Francisca Richbieter) presta uma homenagem à urbanista Francisca Maria Garfunkel Rischbieter, uma das pioneiras no trabalho de planejamento urbano da capital paranaense. Todo o Jardim Botânico possui uma área total de 278 mil metros quadrados, incluindo o bosque com mata atlântica preservada.",
            latitude: -25.4421,
            longitude: -49.2413
        ),
        Place(
            name: "Ópera de Arame",
            image: "operaDeArame1",
            desc: "A Ópera de Arame, com estrutura tubular e teto transparente, é um dos símbolos emblemáticos de Curitiba. Inaugurada em 1992, acolhe todo tipo de espetáculo, do popular ao clássico, e tem capacidade para 1.572 espectadores. Entre lagos, vegetação típica e cascatas, numa paisagem singular, faz parte do Parque Jaime Lerner juntamente com o Espaço Cultural Pedreira Paulo Leminski, cenário de grandes eventos desde 1989, e pode abrigar, ao ar livre, 20.000 pessoas.",
            latitude: -25.3846,
            longitude: -49.2761
        ),
        Place(
            name: "Apple Developer Academy",
            image: "academy1",
            desc: "Apple Developer Academy é um curso de extensão para estudantes aprenderem a desenvolver apps em tecnologias Apple (iOS, iPadOS, watchOS e tvOS). Esta parceria entre Apple™ e PUCPR (Curitiba, PR) teve início em junho de 2013, e por aqui já passaram mais de 370 estudantes. Inicialmente, o curso voltava-se para formação de engenheiros de sistemas e computação. Ao longo dos anos, também foram abertas vagas para designers. Hoje, recebem estudantes dos mais diferentes cursos e formações, que gostam de aprender e criar tecnologias.",
            latitude: -25.452387602831056,
            longitude: -49.24967158860706
        ),
        Place(
            name: "CAAD",
            image: "caad1",
            desc: "CAAD (Centro Acadêmico Alexandre Direne) é o centro acadêmico do curso de Ciência da Computação da UFPR, localizado no Centro Politécnico.",
            latitude: -25.45044848568505,
            longitude: -49.232256816382765
        )
    ]

//    static func readJSONFile() {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: "places", ofType: "json"),
//               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                // Decoding the Product type from JSON data using JSONDecoder() class.
//                places = try JSONDecoder().decode([Place].self, from: jsonData)
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    static func getClosestLocation() -> Place {
        if let closest = PlacesManager.places.first {
            print("Ok + \(closest.getName())")
            return closest
        } else {
            print("??")
//            PlacesManager.readJSONFile()
            return places.first!
        }
    }
    
    static func sortPlaces() {
        places.sort {
            $0.getDistance() < $1.getDistance()
        }
    }
}
